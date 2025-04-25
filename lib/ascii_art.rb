# frozen_string_literal: true

require_relative 'ascii_art/version'
require 'mini_magick'

module AsciiArt
  class Error < StandardError; end

  ASCII_BRIGHTNESS = '`^\",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$'

  image = MiniMagick::Image.open('images/ascii-pineapple.jpg')

  length, width = image.dimensions

  puts 'Successfully constructed pixel matrix!'
  puts "Pixel matrix size: #{length} x #{width}"

  puts 'Iterating through pixel ASCII characters'
  image.get_pixels.each do |group|
    group.each do |pixel|
      pixel_average = pixel.sum / pixel.length
      puts pixel_average
      divisor = (255 / ASCII_BRIGHTNESS.length)
      p ASCII_BRIGHTNESS[(pixel_average / divisor).round]
    end
  end
end
