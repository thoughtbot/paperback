require "RMagick"

module Paperback
  class Cover
    def self.generate
      pdf = source("pdf")
      png = source("png")
      image = Magick::Image.read(pdf) { self.density = 400 }.first
      image.resize 1000, 1000
      image.write(png) { self["png", "exclude-chunk"] = "date,time" }
      png
    end

    def self.source(extension)
      Paperback.target_root.join "images", "cover.#{extension}"
    end
  end
end
