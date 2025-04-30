require 'mini_magick'

module AsciiArt
  class Image
    ASCII_BRIGHTNESS = '`^",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$'.reverse

    attr_reader :filename

    def initialize(path)
      @image = MiniMagick::Image.open(path)
      @filename = File.basename(path, '.*')
    end

    def resize_image
      @image.resize '800'

      length, width = @image.dimensions

      puts "Image resolution after resize: #{length} x #{width}"
    end

    def build_ascii_image(algo)
      puts 'Building ASCII image..'
      divisor = (255.0 / ASCII_BRIGHTNESS.length)

      @image.get_pixels.map do |group|
        row = group.map do |pixel|
          pixel_average = algo.call(pixel)
          ascii = ASCII_BRIGHTNESS[(pixel_average / divisor).round - 1]
          ascii * 2
        end
        row.join
      end
    end
  end
end
