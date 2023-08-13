# frozen_string_literal: true

class DishImageUploader < CarrierWave::Uploader::Base
  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'utensils.svg'
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
