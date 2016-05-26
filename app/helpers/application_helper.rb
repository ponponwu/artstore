module ApplicationHelper
	def notice_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag(:button, "×", close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message

      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"

      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end

  def render_cart_items_count(cart)
    cart.cart_items.count
  end

	def cate_all
    Category.all
  end

  def best_sell
    Product.order("RANDOM()").limit(1)
  end

	def get_photo(photo)
		img = ''
    photo.each_with_index do |p, index|
	     if index != photo.size-1
	       if p.present?
	         img = image_tag(p.image.thumb.url, class: "thumbnail img-responsive")
					 break
	       else
	         next
	       end
	     else
	       if p.present?
	         img = image_tag(p.image.thumb.url, class: "thumbnail img-responsive")
	       else
	         img = image_tag("http://placehold.it/200x200&text=No Pic", class: "thumbnail")
	       end
	     end
   	end
		img
	end
end
