class ProductsController < ApplicationController
  # include ProductsHelper

  def index_page
    @men = Product.where(:gender => 1).limit(5).order("id DESC")
    @women = Product.where(:gender => 2).limit(5).order("id DESC")
  end

  def index
    if params[:category].blank? && params[:brand].blank? && params[:gender].blank?
      @title = 'Products'
      @products = Product.paginate(:page => params[:page], :per_page => 9)
      @products = @q.result.paginate(:page => params[:page], :per_page => 9)
    elsif params[:category]
      @title = params[:category]
      category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 9)
    elsif params[:brand]
      @title = params[:brand]
      brand_id = Brand.find_by(name: params[:brand]).id
      @products = Product.where(brand_id: @brand_id).paginate(:page => params[:page], :per_page => 9)
    elsif params[:gender]
      gender = params[:gender]
      @title = I18n.t("gender.#{gender}")
      @products = Product.where(gender: gender).paginate(:page => params[:page], :per_page => 9)
    end
  end
  def show
  	@product = Product.find(params[:id])
    @photo = @product.photos.all
    @category = Category.find_by(id: @product.category_id)
    @brand = Brand.find_by(id: @product.brand_id)
    @related_product = Product.where(gender: @product.gender).where.not(id: @product.id).order("RANDOM()").limit(4)
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
  def change_product_grid
    # products = Product.where(gender: 1).paginate(:page => params[:page], :per_page => 9)

    respond_to do |format|
      format.js {
        @products = params[:all_product]
      }
    end
  end
  def change_product_list
    products = Product.where(gender: 1).paginate(:page => params[:page], :per_page => 9)

    respond_to do |format|
      format.js {
        @products = products
      }
    end
  end

  protected

  def find_product
    @event = Event.find(params[:id])
  end


end
