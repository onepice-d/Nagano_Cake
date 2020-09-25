module ApplicationHelper

 def price_include_tax(tax_price)
   tax_price = price * 1.08
    "#{tax_price.floor}円"
  end
end
