class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
        vendor.check_stock(item) != 0
      end
  end

  def total_inventory
    total_inventory = Hash.new { |h,k| h[k] = {quantity: 0, vendors: []}}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        total_inventory[item][:quantity] += amount
        total_inventory[item][:vendors] << vendor
      end
    end
    total_inventory
  end

  def overstocked_items
    overstocked = []
    items = total_inventory.select do |item, total_inventory|
        return item if total_inventory[:quantity] > 50 && total_inventory[:vendors].count > 1
    end
    items.each do |k, inventory|
        overstocked << k
    end
    overstocked
  end

  def sorted_item_list
    sorted = []
    @inventory.keys.each do |item|
        sorted << item.name
    end
    sorted.sort
  end

end