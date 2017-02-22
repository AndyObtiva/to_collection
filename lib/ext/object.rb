ENV['TO_COLLECTION_OBJECT_INCLUDE'] ||= 'true'
if ENV['TO_COLLECTION_OBJECT_INCLUDE'].to_s.downcase == 'true'
  Object.class_eval do
    include ToCollection
  end
end
