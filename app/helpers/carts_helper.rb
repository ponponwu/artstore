module CartsHelper
	def render_cart_total_price(cart)
		cart.total_price
	end
	def calculate_current_price(price,amount)
		price*amount
	end
end
