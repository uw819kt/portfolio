require 'rails_helper'
# bundle exec rspec spec/requests/pdf_paid_leave_spec.rb

RSpec.describe "PdfPaidLeave", type: :request do
    let!(:user) { create(:user) }
    let!(:paid_leave) { create(:paid_leave, user: user) }
    let!(:grant) { create(:grant, user: user, paid_leave: paid_leave) }

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

  describe "GET /pdf_paid_leave (HTML)" do
    context "未ログインの場合" do
      it "HTMLリクエストでログインページにリダイレクトされる" do
        get paid_leave_pdf_paid_leave_index_path(paid_leave)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /pdf_paid_leave (PDF)" do
    context "ログイン済みの場合" do
      it "PDFファイルをインラインで返す" do
        send_magic_link_and_login(user)

        get paid_leave_pdf_paid_leave_index_path(paid_leave, format: :pdf)

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/pdf")
        expect(response.headers["Content-Disposition"]).to include("inline")
        expect(response.body).to_not be_empty
      end
    end
  end
end
