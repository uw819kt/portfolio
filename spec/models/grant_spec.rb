require 'rails_helper'
# bundle exec rspec spec/models/grant_spec.rb

RSpec.describe Grant, type: :model do
  it { should belong_to(:paid_leave) }
  it { should belong_to(:user) }

  it { is_expected.to validate_presence_of :granted_piece }
  it { is_expected.to validate_presence_of :granted_day }
  it { is_expected.to validate_presence_of(:paid_leave_id).on(:update) }
  it { should validate_numericality_of(:granted_piece).is_less_than_or_equal_to(99) }
end
