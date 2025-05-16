require 'rails_helper'
# bundle exec rspec spec/models/user_spec.rb

RSpec.describe User, type: :model do
  it { should have_one(:paid_leave).dependent(:destroy) }
  it { should have_many(:requests).dependent(:destroy) }
  it { should have_one(:grant).dependent(:destroy) }
  it { should have_many(:approvals).dependent(:destroy) }
  it { should have_one(:car).dependent(:destroy) }
  it { should have_many(:drive_be_logs).dependent(:destroy) }
  it { should have_many(:drive_af_logs).dependent(:destroy) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :department }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to allow_value("true").for(:is_admin) }
  it { is_expected.to allow_value("false").for(:is_admin) }
  it { is_expected.not_to allow_value(nil).for(:is_admin) }
end
