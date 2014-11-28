class AlbumsController < ApplicationController
  def new
    @album = Album.new

  end
  def index
    @albums = Album.all
  end
  def create

    @album = Album.new(album_params)
    if @album.save
      if params[:images]

        params[:images].each { |image|

          @album.album_images.create(image: image)

        }
      end
      flash[:notice] = "Successfully created trip."
      redirect_to @album
    else
      render :action => 'new'
    end

  end

  def show
    @album  = Album.find(params[:id])
    @album_images = @album.album_images


  end
  def edit
    @album = Album.find(params[:id])
  end
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(album_params)

        if params[:images]

          params[:images].each { |image|
            @album.album_images.create(image: image)
          }
        end
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
      else
        format.html {         render action: "edit"       }
      end
    end

  end


  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }

    end
  end

  def album_params
    params.require(:album).permit(:description,
                                  :title,
                                  :album_images
    )
  end
end