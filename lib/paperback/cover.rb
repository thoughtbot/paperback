require "vips"

module Paperback
  class Cover
    def self.generate
      pdf = source("pdf")
      png = source("png")
      image = Vips::Image.new_from_file pdf.to_s, dpi: 400
      image.write_to_file png.to_s
      png
    end

    def self.source(extension)
      Paperback.target_root.join "images", "cover.#{extension}"
    end
  end
end
