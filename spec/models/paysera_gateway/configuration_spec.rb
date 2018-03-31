require 'rails_helper'

module PayseraGateway
  RSpec.describe Configuration, type: :model do
    it 'has required params' do
      expect(described_class.required_params).to include(:projectid)
    end

    it 'has additional params' do
      expect(described_class.additional_params).to include(:amount)
    end
  end
end
