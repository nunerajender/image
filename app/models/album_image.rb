class AlbumImage < ActiveRecord::Base
  belongs_to :album
  has_attached_file :image,
:styles => { :medium => "600x600>", :thumb => "200x200>" },
                    :path => ":rails_root/public/images/:id/:filename",
                    :url  => "/images/:id/:filename"

   do_not_validate_attachment_file_type :image
end

 
