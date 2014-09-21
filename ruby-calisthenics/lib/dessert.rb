class Dessert
  attr_accessor :name
  attr_accessor :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  def healthy?
    return true if @calories < 200
    return false
  end
  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(flavor)
    @calories = 5
    @name = flavor + " jelly bean"
  end
  def delicious?
    return true unless @flavor=="licorice"
  end
end
