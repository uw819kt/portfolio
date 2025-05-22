require 'rails_helper'
# bundle exec rspec spec/requests/pdf_alcohole_spec.rb

RSpec.describe "PdfAlcohole", type: :request do
  let!(:user) { create(:user) }

  # マジックリンクを送信し、リンクを取得するための共通のメソッド
  def send_magic_link_and_login(user)
    post user_session_path, params: { user: { email: user.email } }
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    email = ActionMailer::Base.deliveries.last
    expect(email.subject).to eq("ログイン用リンクのご案内")

    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    magic_link = CGI.unescapeHTML(magic_link)

    get magic_link
  end

  describe "GET /pdf_alcohole (HTML)" do
    context "未ログインの場合" do
      it "HTMLリクエストでログインページにリダイレクトされる" do
        get pdf_alcohole_index_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /pdf_alcohole (PDF)" do
    let!(:date) { Date.current }
    let!(:be_log) { create(:drive_be_log, user: user, check_time: date.midday) }
    let!(:af_log) { create(:drive_af_log, user: user, check_time: date.midday) }

    it "PDFファイルをインラインで返す" do
      send_magic_link_and_login(user)
      get "/alcohol_logs/pdf_alcohole.pdf", params: { q: { check_time_eq: date.to_s } }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/pdf")
      expect(response.headers["Content-Disposition"]).to include("inline")
      expect(response.body).to_not be_empty
    end

    it "日付を検索していない場合、デフォルトの日付を返す" do
      send_magic_link_and_login(user)

      travel_to date do
        get pdf_alcohole_index_path(format: :pdf)
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/pdf")
      end
    end
  end
end
