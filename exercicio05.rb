class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name + "_history" # create bar_history getter

    # Use %Q for a multi-line string that allows interpolation.
    # This string will be evaluated in the context of the class calling this method.
    class_eval %Q{
      def #{attr_name}=(value)
        # Initialize the history array for this instance if it doesn't exist.
        # The history starts with nil to represent the initial state.
        @#{attr_name}_history ||= [nil]

        # Set the actual instance variable's value for the getter to use.
        @#{attr_name} = value

        # Add the new value to the history array.
        @#{attr_name}_history << value
      end
    }
  end
end

# --- Test Cases ---

# Test case from the problem description
class Foo
  attr_accessor_with_history :bar
end

puts "--- Test Case 1: Basic History Tracking ---"
f = Foo.new
f.bar = 1
f.bar = 2
puts "Current value of f.bar: #{f.bar}"
puts "History of f.bar: #{f.bar_history.inspect}" # Expected: [nil, 1, 2]
puts "\n"

# Test case from the detailed example
puts "--- Test Case 2: Different Value Types ---"
g = Foo.new
g.bar = 3
g.bar = :wowzo
g.bar = 'boo!'
puts "Current value of g.bar: '#{g.bar}'"
puts "History of g.bar: #{g.bar_history.inspect}" # Expected: [nil, 3, :wowzo, 'boo!']
puts "\n"


# Test case to ensure history is per-instance
puts "--- Test Case 3: Instance-Specific History ---"
f1 = Foo.new
f1.bar = 'apple'
f1.bar = 'banana'

f2 = Foo.new
f2.bar = 100
puts "History of f1.bar: #{f1.bar_history.inspect}" # Expected: [nil, 'apple', 'banana']
puts "History of f2.bar: #{f2.bar_history.inspect}" # Expected: [nil, 100]
puts "\n"


# Test case for a different class with multiple tracked attributes
puts "--- Test Case 4: Multiple Attributes in Another Class ---"
class SomeOtherClass
  attr_accessor_with_history :foo
  attr_accessor_with_history :bar
end

s = SomeOtherClass.new
s.foo = :a
s.bar = 1.1
s.foo = :b
s.bar = 2.2
puts "Current value of s.foo: #{s.foo.inspect}"
puts "History of s.foo: #{s.foo_history.inspect}" # Expected: [nil, :a, :b]
puts "Current value of s.bar: #{s.bar}"
puts "History of s.bar: #{s.bar_history.inspect}" 
