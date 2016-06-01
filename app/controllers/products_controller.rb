class ProductsController < ApplicationController
  # include ProductsHelper
  before_action :authenticate_user!, only: [:add_to_cart]
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

  def search
    if params[:search]
      @products = Product.where('title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    else
      @products = Product.all.paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    end
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
      if params[:data].blank?
        current_cart.add_product_to_cart(@product)
      else
        q = params[:data][:quantity]
        sz = params[:data][:size]
    		current_cart.add_product_to_cart_multi(@product,q,sz)
      end
  		flash[:notice] = "你已成功將 #{@product.title}加入購物車 "
  	else
  		flash[:warning] = "你的購物車已有此物品"
  	end

  	redirect_to :back
  end

  def men
    @products = Product.where(gender: 1).paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    @random = Product.order("RANDOM()").limit(1)
    params[:send_params] = @products
    session[:name] = 'gender'
    session[:s_id] = '1'
  end

  def women
    @products = Product.where(gender: 2).paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    session[:name] = 'gender'
    session[:s_id] = '2'
  end
  def kids
    @products = Product.where(gender: 3).paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    session[:name] = 'gender'
    session[:s_id] = '3'
  end
  def categories
    if params[:category]
      @title = params[:category]
      category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: category_id).paginate(:page => params[:page], :per_page => 9).includes(:photos).all
      session[:name] = 'category_id'
      session[:s_id] = category_id
    end
  end

  def brands
    @title = params[:brand]
    brand_id = Brand.find_by(name: params[:brand]).id
    @products = Product.where(brand_id: brand_id).paginate(:page => params[:page], :per_page => 9).includes(:photos).all
    session[:name] = 'brand_id'
    session[:s_id] = brand_id
  end
  def sort
    sortway = params[:sort]
    id = session[:s_id]
    page = (params[:per_page]? 9 : params[:per_page])
    @products = Product.where(session[:name] => id).order(params[:sort]).paginate(:page => params[:page], :per_page => page).includes(:photos).all
  end
  def modify_display_quantity
    id = session[:s_id]
    page = (params[:per_page] ? 3 : params[:per_page])
    @products = Product.where(session[:name] => id).paginate(:page => params[:page], :per_page => page).includes(:photos).all

  end

  # def modify
  #   if params[:per_page]?
  #     @products = Product.where(session[:name] => id).order(params[:sort]).paginate(:page => params[:page], :per_page => params[:per_page])
  #   end
  # end

end
