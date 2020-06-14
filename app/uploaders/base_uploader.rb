class BaseUploader < CarrierWave::Uploader::Base

  private

  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Get-image-dimensions
  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
      # don't have content_type field in photo model yet
      # model.content_type = file.content_type if file.content_type
      model.file_size = file.size
      # below might not normally have to be called
      model.save!
      # but seems to be needed when using .process! to
      # call this on existing images
    end
  end

end
