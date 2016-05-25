class WelcomeController < ApplicationController
  def index
    @latest = Product.limit(4).order("id DESC")
  end
end
