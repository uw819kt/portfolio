require 'rails_helper'
# bundle exec rspec spec/models/paid_leave_spec.rb

RSpec.describe PaidLeave, type: :model do
  it { should belong_to(:user) }
  it { should have_one(:grant).dependent(:destroy) }
  it { should have_many(:requests).dependent(:destroy) }
  it { should have_many(:approvals).dependent(:destroy) }

  it { is_expected.to validate_presence_of :joining_date }
  it { is_expected.to validate_presence_of :base_date }
  it { is_expected.to allow_value("true").for(:part_time) }
  it { is_expected.to allow_value("false").for(:part_time) }
  it { is_expected.not_to allow_value(nil).for(:part_time) }
  it { is_expected.to validate_presence_of :classification }
end
