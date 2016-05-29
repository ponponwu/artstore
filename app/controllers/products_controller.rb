class ProductsController < ApplicationController
  # include ProductsHelper

  def index_page
    @men = Product.where(:gender => 1).limit(5).order("id DESC")
    @women = Product.where(:gender => 2).limit(5).order("id DESC")
  end

  def index

    @title = 'Products'
    @products = Product.paginate(:page => params[:page], :per_page => 9)
    @products = @q.result.paginate(:page => params[:page], :per_page => 9)
    # if params[:search]
    #   @products = Product.all
    #   # @products = Product.where('title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    # else
    #   @products = Product.all
    # end

    # if params[:category].blank? && params[:brand].blank? && params[:gender].blank?
    #   @title = 'Products'
    #   @products = Product.paginate(:page => params[:page], :per_page => 9)
    #   @products = @q.result.paginate(:page => params[:page], :per_page => 9)
    # elsif params[:category]
    #   @title = params[:category]
    #   category_id = Category.find_by(name: params[:category]).id
    #   @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 9)
    # elsif params[:brand]
    #   @title = params[:brand]
    #   brand_id = Brand.find_by(name: params[:brand]).id
    #   @products = Product.where(brand_id: @brand_id).paginate(:page => params[:page], :per_page => 9)
    # elsif params[:gender]
    #   gender = params[:gender]
    #   @title = I18n.t("gender.#{gender}")
    #   @products = Product.where(gender: gender).paginate(:page => params[:page], :per_page => 9)
    # end
  end
  def show
    if params[:search]
      @products = Product.where('title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
    	@product = Product.find(params[:id])
      Product.update_counters @product.id, :view_counts => 1
      @photo = @product.photos.all
      @category = Category.find_by(id: @product.category_id)
      @brand = Brand.find_by(id: @product.brand_id)
      @related_product = Product.where(gender: @product.gender).where.not(id: @product.id).order("RANDOM()").limit(4)

    end
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

  def men
    @products = Product.where(gender: 1).paginate(:page => params[:page], :per_page => 9)
    @random = Product.order("RANDOM()").limit(1)
    params[:send_params] = @products
  end
  def women
    @products = Product.where(gender: 2).paginate(:page => params[:page], :per_page => 9)
  end
  def kids
    @products = Product.where(gender: 3).paginate(:page => params[:page], :per_page => 9)
  end
  def categories
    if params[:category]
      @title = params[:category]
      category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 9)
    end
  end

  def brands
    @title = params[:brand]
    brand_id = Brand.find_by(name: params[:brand]).id
    @products = Product.where(brand_id: brand_id).paginate(:page => params[:page], :per_page => 9)
  end

  protected

  def find_product
    # @event = Event.find(params[:id])
  end


end
