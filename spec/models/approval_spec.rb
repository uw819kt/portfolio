require 'rails_helper'
# bundle exec rspec spec/models/approval_spec.rb

RSpec.describe Approval, type: :model do
  it { should belong_to(:paid_leave) }
  it { should belong_to(:user) }
  it { should belong_to(:request) }

  it { is_expected.to validate_presence_of :request_date }
  it { is_expected.to validate_presence_of :acquisition_date }
  it { is_expected.to allow_value("true").for(:paid_applicable) }
  it { is_expected.to allow_value("false").for(:paid_applicable) }
  it { is_expected.not_to allow_value(nil).for(:paid_applicable) }
  it { is_expected.to allow_value("true").for(:paid_confirm) }
  it { is_expected.to allow_value("false").for(:paid_confirm) }
  it { is_expected.not_to allow_value(nil).for(:paid_confirm) }
  it { is_expected.to validate_length_of(:paid_remarks).is_at_most(255) }
end
