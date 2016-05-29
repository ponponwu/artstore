class WelcomeController < ApplicationController
  def index
    @latest = Product.limit(4).order("id DESC")
    @popular = Product.limit(4).order("view_counts DESC")
  end
  def contact

  end
end
