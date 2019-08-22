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
      if cart[coupItem]
        coupCount = cart[coupItem][:count] + coupons[count][:num]
      else
        coupCount = coupons[count][:num]
      end
      cart[coupItem] = {:price => coupPrice, :clearance => cart[coupons[count][:item]][:clearance], :count => coupCount}
      count += 1
    else
      count += 1
    end
  end
  cart
end

def apply_clearance(cart)
  count = 0
  while cart.keys[count]
    item = cart.keys[count]
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
      count += 1
    else
      count += 1
    end
  end
  cart
end

def checkout(cart, coupons)
  consCart = consolidate_cart(cart)

  coupCart = apply_coupons(consCart, coupons)

  clearCart = apply_clearance(coupCart)

  total = 0
  count = 0
  while clearCart.keys[count]
    item = clearCart.keys[count]
    total += clearCart[item][:price]
    count += 1
  end
  puts total
  if total > 100
    total *= 0.9
  end
  total
end
