class Admin::BrandsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to admin_brands_path
    else
      render :new
    end
  end
  def index
    @brands = Brand.all
  end

  def edit
    @brand = Brand.find(params[:id])

  end
  def update
    @brand = Brand.find(params[:id])

    if @brand.update(brand_params)
      redirect_to admin_brands_path
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

  end
