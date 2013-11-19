module Discounter
  # = A collection of discount rules
  #
  # This methods where born as a refactoring on multiple times having to write
  # them as custom discount rules
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
end
