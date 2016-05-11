class Admin::ProductsController < ApplicationController

  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required
  def new
    @product = Product.new
    @photo = @product.build_photo
    @categories = Category.all
    @brands = Brand.all
    # @category = @product.build_category
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    @brands = Brand.all

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])
    # @category = params[:category_id]
    # @product.category_id = @category

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      # @categories = Category.all
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    # @category = params[:category_id]
    # @product.category_id = @category


    if @product.save
      redirect_to admin_products_path
    else
      # @categories = Category.all
      render :new
    end
  end

  def index
    @products = Product.all
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :category_id, :brand_id, :gender, photo_attributes: [:image, :id] )
  end
end
