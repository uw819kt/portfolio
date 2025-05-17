class PdfAlcohole < Prawn::Document
  def initialize(users, be_logs, af_logs, date)
    super(page_size: "A4", page_layout: :landscape) # A4サイズのPDFを新規作成
    # stroke_axis # 座標を表示

    font_families.update("JP" => {
                            normal: "app/assets/fonts/ipaexm.ttf",
                            bold: "app/assets/fonts/ipaexg.ttf"
                        })
    font "JP"

    #-------- 以下レイアウト ----------
    @users = users
    @be_logs = be_logs
    @af_logs = af_logs

    text "酒気帯び確認記録表", size: 20, align: :center
    move_down 10

    text "興和電気株式会社", size: 10, align: :right
    move_down 10

    text date.to_s, size: 14, align: :left
    move_down 10

    table_data = []

    # ヘッダー1行目
    table_data << [
      { content: "運転者・車両", colspan: 2 },
      { content: "運転前", colspan: 7 },
      { content: "運転後", colspan: 7 },
      { content: "確認欄" }
    ].flatten

    # ヘッダー2行目
    table_data << %w[
      運転者名 車両番号等
      確認年月日 確認方法 検知器使用 測定結果（mg/l） 体調等（状態） 指示事項/その他 確認者
      確認年月日 確認方法 検知器使用 測定結果（mg/l） 体調等（状態） 指示事項/その他 確認者
      安全運転管理者
    ]

    @users.each do |user|
      be_log = @be_logs[user.id]
      af_log = @af_logs[user.id]

      row = []
      row << user.name

      if be_log&.car
        car_info = be_log.car.private_car.presence || be_log.car.company_car
        row << car_info
      else
        row << "-"
      end

      if be_log
        row += [
          be_log.check_time.strftime("%Y/%m/%d %H:%M"),
          be_log.confirmation_i18n,
          be_log.detector_used ? "有" : "無",
          be_log.result.to_s,
          be_log.condition_i18n,
          be_log.log_remarks.to_s,
          "" # 確認者
        ]
      else
        row += Array.new(7, "") + [ "" ]
      end

      if af_log
        row += [
          af_log.check_time.strftime("%Y/%m/%d %H:%M"),
          af_log.confirmation_i18n,
          af_log.detector_used ? "有" : "無",
          af_log.result.to_s,
          af_log.condition_i18n,
          af_log.log_remarks.to_s,
          "", # 確認者
          "" # 安全運転管理者
        ]
      else
        row += Array.new(7, "")
      end

      table_data << row
    end

    table(table_data, header: true, cell_style: { size: 9, inline_format: true, padding: [ 5, 3 ] }) do |t|
      t.row(0).font_style = :bold
      t.row(0).background_color = "DDDDFF"
      t.row(1).background_color = "EEEEEE"
      t.row(0..1).align = :center
      [ 1, 3, 4, 5, 6, 10, 11, 12, 13 ].each { |i| t.column(i).align = :center }
      t.header = true
      { 0 => 50, 1 => 75, 2 => 60, 3 => 30, 5 => 45, 9 => 60, 10 => 30, 12 => 45 }.each { |i, w| t.column(i).width = w }
    end
  end
end
