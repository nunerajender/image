class Album < ActiveRecord::Base
  has_many :album_images, :dependent => :destroy

end
