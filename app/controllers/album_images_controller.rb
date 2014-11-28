class AlbumImagesController < ApplicationController
  def index

    @album = Album.find(params[:album_id])

    @album_images = @album.album_images

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @album_images }
    end
  end


  def show
    @album_image = AlbumImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album_image }
    end
  end


  def new
    @album = Album.find(params[:album_id])
    @album_image = @album.album_images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album_image }
    end
  end


  def edit


    @album_image = AlbumImage.find(params[:id])

  end


  def create
    @album_image = AlbumImage.new(params[:album_image_params])

    if @album_image.save
      respond_to do |format|
        format.html {
          render :json => [@album_image.to_jq_upload].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {
          render :json => [@album_image.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end


  def update

    @album = Album.find(params[:album_id])

    @album_image = @album.album_images.find(params[:id])

    respond_to do |format|
      if @album_image.update_attributes(album_image_params)
        format.html { redirect_to album_path(@album), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album_image.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy

    @album_image = AlbumImage.find(params[:id])
    @album_image.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def make_default
    @album_image = AlbumImage.find(params[:id])
    @album = Album.find(params[:album_id])

    @Album.cover = @album_image.id
    @album.save

    respond_to do |format|
      format.js
    end
  end

  private

  def album_image_params
    params.require(:album_image).permit( :album_id, :image)
  end
end
