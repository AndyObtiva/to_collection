require 'spec_helper'

describe 'to_collection' do
  describe 'to_collection' do
    context 'single object' do
      it 'returns single object wrapped in an array' do
        expect(1.to_collection).to eq([1])
      end
      it 'returns another object wrapped in an array' do
        expect('yasmine'.to_collection).to eq(['yasmine'])
      end
      it 'returns empty array for nil' do
        expect(nil.to_collection).to eq([])
      end
      it 'returns array with nil for nil when passing compact=false' do
        expect(nil.to_collection(false)).to eq([nil])
      end
      it 'returns array without nil for nil when passing compact=true explicitly' do
        expect(nil.to_collection(true)).to eq([])
      end
    end
    context 'array of objects' do
      it 'returns one-dimensional array with single item as is' do
        expect([1].to_collection).to eq([1])
      end
      it 'returns one-dimentional array with multiple items as is' do
        expect(['yasmine', 'abir'].to_collection).to eq(['yasmine', 'abir'])
      end
      it 'returns one-dimentional array with multiple items including nil without the nil' do
        expect(['yasmine', nil, 'abir', nil].to_collection).to eq(['yasmine', 'abir'])
      end
      it 'returns one-dimentional array with multiple items including nil with the nil when passing compact=false' do
        expect(['yasmine', nil, 'abir', nil].to_collection(false)).to eq(['yasmine', nil, 'abir', nil])
      end
      it 'returns one-dimentional array with multiple items including nil without the nil when passing compact=true explicitly' do
        expect(['yasmine', nil, 'abir', nil].to_collection(true)).to eq(['yasmine', 'abir'])
      end
      it 'returns empty array for an array containing nil' do
        expect([nil].to_collection).to eq([])
      end
      it 'returns array with nil for nil when passing compact=false' do
        expect([nil].to_collection(false)).to eq([nil])
      end
    end
    context 'array of arrays of objects' do
      it 'returns two-dimensional array as is' do
        expect([[1]].to_collection).to eq([[1]])
      end
      it 'returns two-dimensional array as is for an array containing nil' do
        expect([nil].to_collection).to eq([])
      end
    end
  end
  describe 'each_as_collection' do

  end
end
