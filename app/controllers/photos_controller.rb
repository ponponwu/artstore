class PhotosController < ApplicationController

  before_action :set_image, only: :destroy
  def update
    @photo = Photo.find(params[:id])
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to edit_photo_path(@photo), notice: 'Photo was successfully updated.' }
      else
        format.html {render :edit}
      end
    end
  end

  def show

  end

  def edit
    @photo = Photo.find(params[:id])
  end




   def destroy
     respond_to do |format|
       if @photo.destroy
         format.html {redirect_to edit_admin_product_path(session[:product_id])}
       else
         format.html {redirect_to :back, notice: "You can't delete this image"}
       end
     end
   end


private
  def photo_params
    params.require(:photo).permit(:image)
  end

  def set_image
    @photo = Photo.find(params[:id])
  end


end
