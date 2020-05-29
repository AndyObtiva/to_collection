require 'spec_helper' # includes Object#to_collection implementation

describe 'to_collection' do  
  describe 'to_collection already exists and not using refinement' do
    let(:expected_value) { 'already implemented' }
    context 'single object' do
      it 'returns "already implemented" for single object wrapped in an array' do
        expect(1.to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for another object wrapped in an array' do
        expect('yasmine'.to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for empty array for nil' do
        expect(nil.to_collection).to eq(expected_value)
      end
    end
    context 'array of objects' do
      it 'returns "already implemented" for one-dimensional array with single item as is' do
        expect([1].to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for one-dimentional array with multiple items as is' do
        expect(['yasmine', 'abir'].to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for one-dimentional array with multiple items including nil without the nil' do
        expect(['yasmine', nil, 'abir', nil].to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for empty array for an array containing nil' do
        expect([nil].to_collection).to eq(expected_value)
      end
    end
    context 'array of arrays of objects' do
      it 'returns "already implemented" for two-dimensional array as is' do
        expect([[1]].to_collection).to eq(expected_value)
      end
      it 'returns "already implemented" for two-dimensional array as is for an array containing nil' do
        expect([nil].to_collection).to eq(expected_value)
      end
    end
  end
end
