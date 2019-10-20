require 'rails_helper'

RSpec.describe Parking, type: :model do
  it { should validate_presence_of(:plate) }
  it { should allow_value("XYZ-1234").for(:plate) }
  it { should allow_value("HVE-4603").for(:plate) }
  it { should_not allow_value("New York").for(:plate) } 
  it { should_not allow_value("123-ZXCV").for(:plate) } 
  it { should_not allow_value("AAA-1!$3").for(:plate) } 
end
