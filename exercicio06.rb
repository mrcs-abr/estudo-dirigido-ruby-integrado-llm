class Numeric
  @@currencies = {
    'dollar' => 1.0,
    'yen' => 0.013,
    'euro' => 1.292,
    'rupee' => 0.019
  }

  def method_missing(method_id, *args, &block)
    singular_currency = method_id.to_s.gsub(/s$/, '')

    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def in(target_currency)
    singular_target = target_currency.to_s.gsub(/s$/, '')

    if @@currencies.has_key?(singular_target)
      self / @@currencies[singular_target]
    else
      raise NoMethodError, "Undefined currency #{target_currency}"
    end
  end

  def respond_to_missing?(method_id, include_private = false)
    singular_currency = method_id.to_s.gsub(/s$/, '')
    @@currencies.has_key?(singular_currency) || super
  end
end

puts 5.dollars.in(:euros)  

puts 10.euros.in(:rupees) 

puts 1.dollar.in(:rupees)
puts 100.yen.in(:euro)  




def String
  def palindrome?
    self.downcase.gsub(/\W/, "") == self.downcase.gsub(/\W/, "").reverse
  end
end

def Enumerable
  def palindrome?
    self == self.reverse
  end 
end

