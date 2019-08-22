def consolidate_cart(cart)
  consCart = {}
  cart.map { |groc|
    grocItem = groc.keys[0]
    if consCart[grocItem]
      consCart[grocItem][:count] += 1
    else
      consCart[grocItem] = groc[grocItem]
      consCart[grocItem][:count] = 1
    end
  }
  consCart
end

def apply_coupons(cart, coupons)
  count = 0
  while coupons[count] do
    if cart[coupons[count][:item]]
      cart[coupons[count][:item]][:count] -= coupons[count][:num]
      coupItem = "#{coupons[count][:item]} W/COUPON"
      coupPrice = coupons[count][:cost] / coupons[count][:num]
      cart[coupItem] = {:price => coupPrice, :clearance => true, :count => coupons[count][:num]}
      count += 1
    else
      count += 1
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
