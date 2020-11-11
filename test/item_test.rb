require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
    def setup
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    end

    def test_exists_with_attributes
      assert_instance_of Item, @item2
      assert_equal "Tomato", @item2.name
      assert_equal 0.5, @item2.price
    end
end