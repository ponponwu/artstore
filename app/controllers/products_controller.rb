class ProductsController < ApplicationController
  include ProductsHelper

  def IndexPage
    @men = Product.where(:gender => 1).limit(5).order("id DESC")
    @women = Product.where(:gender => 2).limit(5).order("id DESC")
  end

  def index
    if params[:category].blank? && params[:brand].blank? && params[:gender].blank?
      @category_name = 'Products'
      @products = Product.paginate(:page => params[:page], :per_page => 9)
      @products = @q.result.paginate(:page => params[:page], :per_page => 9)
    elsif params[:category]
      @category_name = params[:category]
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 9)
    elsif params[:brand]
      @category_name = params[:brand]
      # @category_id = Category.find_by(name: params[:category]).id
      # @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 9)
    elsif params[:gender]
      gender = params[:gender]
      @category_name = current_gender(gender)
      @products = Product.where(gender: gender).paginate(:page => params[:page], :per_page => 9)
    end
  end
  def show
  	@product = Product.find(params[:id])
    @category = Category.find_by(id: @product.category_id)
  end

  def add_to_cart
  	@product = Product.find(params[:id])

  	if !current_cart.items.include?(@product)
  		current_cart.add_product_to_cart(@product)
  		flash[:notice] = "你已成功將 #{@product.title}加入購物車 "
  	else
  		flash[:warning] = "你的購物車已有此物品"
  	end

  	redirect_to :back
  end

end
