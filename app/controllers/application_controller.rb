class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart
  # before_action :cate_all
  before_action :set_search
  #讓在執行任何動作之前，先呼叫set_search，才能讓view知道 @q 是啥！不然會噴錯，說他找不到ransack！


  def current_cart
  	@current_cart ||= find_cart
  end

  def admin_required
  	if !current_user.admin?
  		redirect_to "/"
  	end
  end

  # def cate_all
  #   @categories = Category.all
  # end

  protected
    def set_search
      @q = Product.search(params[:q])
    end

  private

  def find_cart
  	cart = Cart.find_by(id: session[:cart_id])

  	unless cart.present?
  		cart = Cart.create
  	end

  	session[:cart_id] = cart.id
  	cart
  end
  # def render_cart_items_count(cart)
  #   cart.cart_items.count
  # end

end
