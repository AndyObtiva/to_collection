# Copyright (c) 2017-2020 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module ToCollection
  if RUBY_PLATFORM == 'opal'
    def self.refine(class_or_module, &refinement)
      class_or_module.class_eval(&refinement)
    end
  end
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

if RUBY_PLATFORM == 'opal'
  # Create a shim `using` method that does nothing since we monkey-patch in Opal earlier in the `refine` method
  def self.using(refinement)
    # NO OP
  end
end
