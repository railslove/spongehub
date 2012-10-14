# encoding: utf-8
class BannerImageUploader < ImageUploader

  version :wide do
    process resize_to_fill: [900, 240]
  end

  version :homepage do
    process resize_to_fill: [280, 210]
  end

end