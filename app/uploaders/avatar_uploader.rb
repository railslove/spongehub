# encoding: utf-8
class AvatarUploader < ImageUploader

  version :square do
    process resize_to_fill: [80, 80]
  end

end