class Item
  attr_reader :name,
              :price
  def initialize(hash)
    @name  = hash[:name]
    @price = hash[:price].reverse.chop!.reverse.to_f
  end
end