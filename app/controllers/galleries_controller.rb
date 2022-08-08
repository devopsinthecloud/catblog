class GalleriesController < ApplicationController
  def create
    @gallery = Gallery.find(params[:gallery_id])
    redirect_to gallery_path(@gallery)
  end

  def destroy
    @gallery = Gallery.find(params[:gallery_id])
    @gallery.destroy
    redirect_to gallery_path(@gallery), status: 303
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  # private
  #   def comment_params
  #     params.require(:comment).permit(:commenter, :body, :status)
  #   end
end
