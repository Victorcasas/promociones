class Calculo < ActiveRecord::Base


  has_no_table

  column :cantidadAM, :integer
  column :cantidadAC, :integer
  column :cantidadCA, :integer

  validates_presence_of :cantidadAM
  validates_presence_of :cantidadAC
  validates_presence_of :cantidadCA


  class Item
    attr_accessor :code, :name, :price

    def initialize(code, name, price)
      @code = code
      @name = name
      @price = price
    end
  end

  class DiscountRules
    def simple(configuration)
      -> { 0 }
    end

    def descuento_fijo(configuration)
      ->(args) do
        items = args[:checkout].items.select { |item| item.code == configuration[:code] }
        (items.count >= configuration[:limit]) ? configuration[:discount] * items.count : 0
      end
    end
    def dos_por_uno(configuration)
      ->(args) do
        items = args[:checkout].items.select { |item| item.code == configuration[:code] }
	resto = items.count.modulo(2)
	(items.count >= configuration[:limit]) ? configuration[:discount] * (items.count-items.count.modulo(2))/2 : 0
      end
    end
  end
  
  class Checkout
    attr_reader :rules, :items

    def initialize(rules)
      @rules = rules
      @items = []
    end

    def scan(item)
      @items << item
    end

    def total
      @rules.inject(subtotal) { |count, discount_rule| count - discount_rule.call({ checkout: self, count: count }) }.round(2)
    end

    private

    def subtotal
      items.inject(0) { |total, item| total + item.price }
    end
  end  

  def obtener_calculo
    pricing_rules = []
    discount_rules = DiscountRules.new
    # Everyday discounts that you don't wanna retype every time
    pricing_rules << discount_rules.dos_por_uno({ code: "001", limit: 2, discount: 3.11 })
    pricing_rules << discount_rules.descuento_fijo({ code: "002", limit: 3, discount: 0.50 })
    co = Checkout.new(pricing_rules)
    (1..self.cantidadAM).each do |i|
      co.scan Item.new("001", "AM", 3.11)
    end
    (1..self.cantidadAC).each do |i|
      co.scan Item.new("002", "AC", 5.00)
    end
    (1..self.cantidadCA).each do |i|
      co.scan Item.new("003", "CA", 11.23)
    end
    price = co.total
    return price
  end
end
