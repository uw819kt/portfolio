require 'rails_helper'
# bundle exec rspec spec/models/car_spec.rb

RSpec.describe Car, type: :model do
  it { should belong_to(:user) }

  it { is_expected.to validate_length_of(:company_car).is_at_most(30) }
  it { is_expected.to validate_length_of(:private_car).is_at_most(30) }
end
