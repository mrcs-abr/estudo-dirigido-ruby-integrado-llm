class Dessert
  def initialize (name, calories)
    @name = name
    @calories = calories
  end
    
  attr_accessor :name, :calories

  def healthy?
    if @calories < 200
      return true
    else
      return false
    end 
  end

  def delicious?
    true
  end

end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    @name = name
    @calories = calories
    @flavor = flavor
  end
  
  attr_accessor :flavor

  def delicious?
    if @flavor == "black licorice"
      return false
    else
      return true
    end 
  end

end


sobremesa_jelly1 = JellyBean.new("jellybeans", 200, "black licorice")
puts "jelly1"
puts "name: " + sobremesa_jelly1.name.to_s
puts "flavor: " + sobremesa_jelly1.flavor.to_s  
puts "delecious? " + sobremesa_jelly1.delicious?.to_s 
puts 

sobremesa_jelly2 = JellyBean.new("jellybeans2", 300, "qualquer")
puts "jelly2"
puts "name: " + sobremesa_jelly2.name.to_s
puts "flavor: " + sobremesa_jelly2.flavor.to_s  
puts "delecious? " + sobremesa_jelly2.delicious?.to_s 
puts 


sobremesa = Dessert.new("Brigadeiro", 300)
sobremesa.calories = "199"
puts sobremesa.calories
puts sobremesa.delicious?

