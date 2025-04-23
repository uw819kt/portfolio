require 'rails_helper'
# bundle exec rspec spec/models/paid_leave_spec.rb

RSpec.describe PaidLeave, type: :model do
  it { should belong_to(:user) }
  # it { should belong_to(:grant) }
  it { should have_many(:requests) }
  it { should have_many(:approvals) }

  it { is_expected.to validate_presence_of :joining_date }
  it { is_expected.to validate_presence_of :base_date }
  it { is_expected.to validate_presence_of :part_time }
  it { is_expected.to validate_presence_of :classification }
end
