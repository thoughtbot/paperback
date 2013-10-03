require 'RMagick'

module Paperback
  class Cover
    def self.generate
      pdf = source('pdf')
      png = source('png')
      image = Magick::Image.read(pdf) { self.density = 400 }.first
      image.resize 1000, 1000
      image.write png
      png
    end

    private

    def self.source(extension)
      Pathname.new('images').join "cover.#{extension}"
    end
  end
end
