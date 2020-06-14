class PhotoRecord < ApplicationRecord
  self.abstract_class = true
  
  extend Mobility
  mob_translates :alt_text

  # TODO - add optimised cloudinary images ..
  mount_uploader :image, GenericPhotoUploader
  # has_one_attached :image

  # , touch: true
  # globalize_accessors locales: I18n.available_locales,
  #   attributes: [:alt_text]

  # TODO may 2018 - use optimized_image_url in my code
  def optimized_image_url
    unless image.url.present?
      # if this method is called too soon after an image is
      # uploaded, might need to reload the record to
      # have the url available
      reload
    end
    if Rails.application.config.use_cloudinary
      options = {height: 800, crop: "scale", quality: "auto"}
      image_url = Cloudinary::Utils.cloudinary_url image, options
    else
      image_url = image.url
    end
    image_url
  end


  after_create :set_folder


  def as_json(options = nil)
    super({only: [
             "id",
             "sort_order", "image",
             "file_size", "content_type",
             "height", "width"
           ],
           methods: []}.merge(options || {}))
  end

  # def admin_attribute_names
  #   globalize_attribute_names
  #   # self.globalize_attribute_names.push :content_photos
  # end

  private

  def set_folder
    self.folder = "pisocake"
    # self.folder = Apartment::Tenant.current.presence || "shared"
    save
  end
end
