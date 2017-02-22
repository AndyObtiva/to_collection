require 'spec_helper'

describe 'to_collection' do
  describe 'to_collection' do
    let(:lib_ext_object_path) {
      File.expand_path("#{__FILE__}/../../../lib/ext/object.rb")
    }
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
    context 'object already having to_collection' do
      before do
        Object.to_collection_already_implemented_strategy = ENV['TO_COLLECTION_ALREADY_IMPLEMENTED_STRATEGY'] = nil
        Object.send(:remove_method, :to_collection) rescue nil
        Object.send(:remove_method, :to_collection_already_implemented) rescue nil
        Object.send(:remove_method, :to_collection_already_implemented_wrapped) rescue nil
        class Object
          # custom implementation returns collection of attributes
          def to_collection
            [self.class, self]
          end
        end
      end
      it "raises AlreadyImplementedError if to_collection_already_implemented_strategy is undefined (defaults to :raise_error)" do
        expect {load(lib_ext_object_path)}.to raise_error(AlreadyImplementedError)
      end
      it "raises AlreadyImplementedError if to_collection_already_implemented_strategy is :raise_error" do
        Object.to_collection_already_implemented_strategy = :raise_error
        expect {load(lib_ext_object_path)}.to raise_error(AlreadyImplementedError)
      end
      it "keeps existing to_collection implementation if to_collection_already_implemented_strategy is :keep" do
        Object.to_collection_already_implemented_strategy = :keep
        load(lib_ext_object_path)
        object = Object.new
        expect(object.to_collection).to eq([object.class, object])
      end
      it "overwrites existing to_collection implementation if to_collection_already_implemented_strategy is :overwrite" do
        Object.to_collection_already_implemented_strategy = :overwrite
        load(lib_ext_object_path)
        object = Object.new
        expect(object.to_collection).to eq([object])
      end
      it "keeps existing to_collection implementation if ENV['TO_COLLECTION_ALREADY_IMPLEMENTED_STRATEGY'] is :keep" do
        ENV['TO_COLLECTION_ALREADY_IMPLEMENTED_STRATEGY'] = 'keep'
        load(lib_ext_object_path)
        object = Object.new
        expect(object.to_collection).to eq([object.class, object])
      end
    end
    context 'manual inclusion of ToCollection' do
      before do
        Object.send(:remove_method, :to_collection) rescue nil
      end
      it "does not include ToCollection in Object when ENV['TO_COLLECTION_OBJECT_INCLUDE'] is false" do
        ENV['TO_COLLECTION_OBJECT_INCLUDE'] = 'false'
        load(lib_ext_object_path)
        expect {Object.new.to_collection}.to raise_error(NameError)
      end
    end
  end
end
