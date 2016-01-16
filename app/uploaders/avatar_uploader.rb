# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick


  # HAVE TO HAVE install Imagemagick before miniMagick will work
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/" + ["default.jpeg"].compact.join('_'))
  #
    # "/fallback/" + [:profile, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # automatically resizes the user-upload to a smaller scale
  def scale(width, height)
    process :scale => [300, 275]
  end

  # Create different versions of your uploaded files:
  version :user do
    process :resize_to_fit => [300, 300]
  end
  
  # creates a version of the upload to be used for profile images on the home page
  # having it size down from the user version speeds up processing a bit as the image is already smaller
  version :profile, :from_version => :user do
    process :resize_to_fit => [120, 120]
  end

  # creates a version of the upload to be used for thumbnail images throughout the site
  version :thumb, :from_version => :profile do
    process :resize_to_fit => [50, 50]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
