require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
    def setup
      @market = Market.new("South Pearl Street Farmers Market")
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: "$0.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")
      @item5 = Item.new({name: 'Onion', price: '$0.25'})
    end

    def test_exists_with_attributes
      assert_instance_of Market, @market
      assert_equal "South Pearl Street Farmers Market", @market.name
      assert_equal [], @market.vendors
    end

    def test_stock
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      assert_equal 35, @vendor1.check_stock(@item1)
      assert_equal 7, @vendor1.check_stock(@item2)
      
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      assert_equal 50, @vendor2.check_stock(@item4)
      assert_equal 25, @vendor2.check_stock(@item3)

      @vendor3.stock(@item1, 65)
      assert_equal 65, @vendor3.check_stock(@item1)
    end

    def test_add_vendor
      @market.add_vendor(@vendor1)
      assert_equal [@vendor1], @market.vendors

      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      assert_equal [@vendor1, @vendor2, @vendor3], @market.vendors
    end

    def test_vendor_names
      @market.add_vendor(@vendor1)
      assert_equal ["Rocky Mountain Fresh"], @market.vendor_names
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @market.vendor_names
    end

    def test_vendors_that_sell
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      
      assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
    end

    def test_potential_revenue
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)

      assert_equal 29.75, @vendor1.potential_revenue
      assert_equal 345.00, @vendor2.potential_revenue
      assert_equal 48.75, @vendor3.potential_revenue
    end

    def test_total_inventory
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 60)
      @vendor3.stock(@item3, 10)
      
      assert_equal 4, @market.total_inventory.count
    end

    def test_overstocked_items
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 60)
      @vendor3.stock(@item3, 10)

      assert_equal @item1, @market.overstocked_items
    end

    def test_sorted_item_list
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 60)
      @vendor3.stock(@item3, 10)

      assert_equal ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"], @market.sorted_item_list
    end
end