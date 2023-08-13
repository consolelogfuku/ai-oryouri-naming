# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'robot_with_shadow.png'
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
