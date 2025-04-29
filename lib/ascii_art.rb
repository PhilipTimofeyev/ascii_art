# frozen_string_literal: true

require_relative 'ascii_art/version'
require 'mini_magick'

def luminosity(pixel)
  (0.21 * pixel[0] + 0.72 * pixel[1] + 0.07 * pixel[2]) / 3
end

def lightness(pixel)
  (pixel.max + pixel.min) / 2
end

def average(pixel)
  pixel.sum / 3
end

module AsciiArt
  class Error < StandardError; end

  ASCII_BRIGHTNESS = '`^",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$'.reverse

  image = MiniMagick::Image.open('images/caravaggio.jpg')
  image.resize '1699'

  length, width = image.dimensions

  puts 'Successfully constructed pixel matrix!'
  puts "Pixel matrix size: #{length} x #{width}"

  puts 'Building ASCII image..'
  divisor = (255.0 / ASCII_BRIGHTNESS.length)
  result = []

  image.get_pixels.each do |group|
    row = group.map do |pixel|
      pixel_average = average(pixel)
      ascii = ASCII_BRIGHTNESS[(pixel_average / divisor).round - 1]
      ascii * 2
    end
    result << row.join
  end
  File.write('ascii_image.txt', result.join("\n"))
end
