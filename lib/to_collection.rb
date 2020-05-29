# require 'super_module'

module ToCollection
  refine Object do
    begin
      method(:to_collection)
      puts "ToCollection Warning: Object#to_collection already exists! using ToCollection overwrites it with a Ruby Refinement."
    rescue NameError
      # No Op
    ensure
      def to_collection(compact=true)
        collection = [self].flatten(1)
        compact ? collection.compact : collection
      end
    end
  end
end
