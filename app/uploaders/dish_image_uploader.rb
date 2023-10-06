class DishImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  version :dish_card do
    process resize_to_fill: [320, 240, gravity='Center']
  end

  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'preview.svg'
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
