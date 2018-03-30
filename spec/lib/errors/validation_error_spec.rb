RSpec.describe PayseraGateway::ValidationError do
  let(:error_message) { 'Validation error message' }
  let(:details) do
    {
      param: 'Error message for param'
    }
  end

  it 'takes message' do
    error = described_class.new(error_message, {})
    expect(error.message).to eq(error_message)
  end

  it 'takes details hash' do
    error = described_class.new(error_message, details)
    expect(error.details).to eq(details)
  end
end
