class Admin::ProductsController < ApplicationController

  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required
  def new
    @product = Product.new
    @photo = @product.photos.build
    @categories = Category.all
    @brands = Brand.all
    # @category = @product.build_category
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    @brands = Brand.all
    @photo = @product.photos.all
    session[:product_id] = params[:id]
    # if @product.photos.present?
    #   @photo = @product.photo
    # else
    #   @photo = @product.build_photo
    # end
  end

  def update
    @product = Product.find(params[:id])
    # @category = params[:category_id]
    # @product.category_id = @category
    respond_to do |format|
      if @product.update(product_params)
        if @product.save
          params[:product][:photo][:image].each do |i|
            @photo = @product.photos.create!(:image => i)
          end
          format.html {redirect_to edit_admin_product_path(session[:product_id]), notice: 'Post was successfully updated.' }
        else
          # @categories = Category.all
          render :edit
        end
      else
        # @categories = Category.all
        render :edit
      end
    end
  end

  def create
    @product = Product.new(product_params)
    # @category = params[:category_id]
    # @product.category_id = @category

    respond_to do |format|
      if @product.save
        params[:product][:photo][:image].each do |i|
          @photo = @product.photos.create!(:image => i)
        end
        format.html {redirect_to admin_products_path, notice: 'Post was successfully created.' }
      else
        # @categories = Category.all
        render :new
      end
    end
  end

  def index
    @products = Product.includes(:photos).all
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :category_id, :brand_id, :gender, photos_attributes: [:id, :product_id, :image] )
  end
end
