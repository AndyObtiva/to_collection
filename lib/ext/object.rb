ENV['TO_COLLECTION_OBJECT_INCLUDE'] ||= 'true'
Object.include(ToCollection) if ENV['TO_COLLECTION_OBJECT_INCLUDE'].to_s.downcase == 'true'
