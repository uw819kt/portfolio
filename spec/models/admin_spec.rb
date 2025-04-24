require 'rails_helper'
# bundle exec rspec spec/models/admin_spec.rb

RSpec.describe Admin, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
end
