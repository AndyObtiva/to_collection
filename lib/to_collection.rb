require 'super_module'

ToCollection = super_module do
  class AlreadyImplementedError < StandardError
  end

  def self.to_collection_already_implemented_strategy=(strategy)
    @to_collection_already_implemented_strategy = strategy
  end

  def self.to_collection_already_implemented_strategy
    (ENV['TO_COLLECTION_ALREADY_IMPLEMENTED_STRATEGY'] ||
      @to_collection_already_implemented_strategy ||
      :raise_error).to_sym
  end

  def __to_collection__(compact=true)
    collection = [self].flatten(1)
    compact ? collection.compact : collection
  end

  def self.define_to_collection_method
    define_method(:to_collection, instance_method(:__to_collection__))
    send(:remove_method, :__to_collection__)
  end

  case self.to_collection_already_implemented_strategy
  when :raise_error
    begin
      instance_method(:to_collection)
      message = "#to_collection is already implemented on Object. Please specify Object.to_collection_already_implemented_strategy or ENV['TO_COLLECTION_ALREADY_IMPLEMENTED_STRATEGY'] as :keep or :overwrite to handle this appropriately."
      raise AlreadyImplementedError.new(message)
    rescue NameError
      self.define_to_collection_method
    end
  when :keep
    # do nothing
  when :overwrite
    self.define_to_collection_method
  end

end

require File.expand_path(File.join(__FILE__, '..', 'ext', 'object'))
