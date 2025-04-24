require 'rails_helper'
# bundle exec rspec spec/models/approval_spec.rb

RSpec.describe Approval, type: :model do
  it { should belong_to(:paid_leave) }
  it { should belong_to(:user) }

  it { is_expected.to validate_presence_of :request_date }
  it { is_expected.to validate_presence_of :acquisition_date }
  it { is_expected.to validate_presence_of :paid_applicable }
  it { is_expected.to validate_presence_of :paid_confirm }
  it { is_expected.to validate_length_of(:paid_remarks).is_at_most(255) }
end
