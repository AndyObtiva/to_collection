Object.class_eval do
  #TODO handle case where to_collection already found
  #Alias? Or Erase and Replace?
  def to_collection(compact=true)
    collection = [self].flatten(1)
    compact ? collection.compact : collection
  end
end
