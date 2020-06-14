class GenericPhotoUploader < BaseUploader
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include Cloudinary::CarrierWave
  include Cloudinary::CarrierWave if Rails.application.secrets.cloudinary_url

  process :store_dimensions

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if model.folder.present?
      tenant_prefix = model.folder
      # model.folder should contain tenant name
      (tenant_prefix += "_dev" ) if ENV["RAILS_ENV"] == "development"
      "uploads/#{model.folder}/#{model.class.to_s.underscore}/#{model.id}"
    else
      "#{model.class.to_s.underscore}/#{model.id}"
    end
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  # # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Dynamically-set-storage-type
  # def self.set_storage
  #   unless Rails.application.secrets.cloudinary_url
  #     :file
  #   end
  # end

  # storage set_storage


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]


  # - below works with cloudinary but disabling for now
  # till I find a non-cloudinary solution
  # process resize_to_limit: [1400, 1000]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # note - if I change or add versions after images are created
  # a call like "blah.prop_photos.first.image.thumb_fill.url" will
  # return a url but the image will not exist at that url
  version :small_fill do
    # can exceed dimensions below
    process resize_to_fill: [200,200]
  end

  version :small_fit do
    process resize_to_fit: [200,200]
  end

  # version :thumb_fill do
  #   process resize_to_fill: [100,100]
  # end

  # version :thumb_fit do
  #   process resize_to_fit: [100,100]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # private

  # # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Get-image-dimensions
  # def store_dimensions
  #   if file && model
  #     model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
  #     # don't have content_type field in photo model yet
  #     # model.content_type = file.content_type if file.content_type
  #     model.file_size = file.size
  #     # below might not normally have to be called
  #     model.save!
  #     # but seems to be needed when using .process! to
  #     # call this on existing images
  #   end
  # end

end

