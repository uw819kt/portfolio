class PdfPaidLeave < Prawn::Document
  def initialize(paid_leave, user, grant, approvals, achievements, date)
    super(page_size: "A4") # A4サイズのPDFを新規作成
    # stroke_axis # 座標を表示

    font_families.update("JP" => {
                            normal: "app/assets/fonts/ipaexm.ttf",
                            bold: "app/assets/fonts/ipaexg.ttf"
                        })
    font "JP"

    #-------- 以下レイアウト ----------
    text "#{Date.today.year}年 有給休暇取得計画表", size: 20, align: :center
    move_down 20

    text "興和電気株式会社", size: 11, align: :right
    move_down 10

    # --- 部署・名前表示 ---
    table([
      [ "部署", user.department_i18n ],
      [ "氏名", user.name ]
    ],
      position: :right,
      cell_style: {
        borders: [ :bottom ],   # 下線のみ
        border_width: 1,
        border_color: "000000",
        padding: [ 2, 4 ],
        size: 10
      },
      column_widths: [ 50, 70 ]) do |t|
      t.column(0).font_style = :bold
    end

    # --- 印刷日時表示 ---
    indent(35) do
      text date.to_s, size: 12, align: :left
    end
    move_down 5

    # --- 基本情報テーブル ---
    table([
      [ { content: "基準日", colspan: 2, background_color: "DDDDFF" }, { content: I18n.l(paid_leave.base_date, format: :long), colspan: 4 } ],
      [ { content: "有効期間", colspan: 2, background_color: "DDDDFF" }, { content: "#{I18n.l(paid_leave.base_date, format: :long)}～#{I18n.l(paid_leave.base_date.next_year - 1, format: :long)}", colspan: 4 } ],
      [
        { content: "合計日数", background_color: "DDDDFF" },
        grant.granted_piece.to_s,
        { content: "前年度繰越分", background_color: "DDDDFF" },
        "-", # ←データなし
        { content: "今年度付与分", background_color: "DDDDFF" },
        grant.granted_piece.to_s
      ]
    ], cell_style: { size: 10, padding: [ 5, 3 ] },
       position: :center,
       column_widths: [ 85, 70, 85, 70, 85, 85 ] # 合計 = 480pt
       ) do |t|
         t.cells.border_width = 1
    end

    # --- 承認一覧テーブル ---
    header = [
      "No", "届出年月日", "取得日", "残日数", "本人印", "承認印", "備考", "通常有給適用", "有給申請確認"
    ]

    body = approvals.each_with_index.map do |approval, index|
      [
        index + 1,
        I18n.l(approval.request_date, format: :long),
        I18n.l(approval.acquisition_date, format: :long),
        achievements.to_s,  # ←残日数のロジックは別途コントローラ側で渡す
        "", "",  # 印欄は空
        approval.paid_remarks.to_s,
        approval.paid_applicable ? "適用" : "未適用",
        approval.paid_confirm ? "承認済" : "承認未"
      ]
    end

    table([ header ] + body, header: true,
      position: :center,
      cell_style: { size: 9, padding: [ 10, 2 ], min_height: 35 },
      column_widths: [ 25, 75, 75, 35, 40, 40, 70, 60, 60 ] # 合計 = 450pt
      ) do |t|
        t.row(0).font_style = :bold
        t.row(0).background_color = "DDDDFF"
        t.columns(0..8).align = :center
    end
  end
end
