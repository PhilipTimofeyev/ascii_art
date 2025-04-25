# frozen_string_literal: true

require_relative 'ascii_art/version'
require 'mini_magick'

module AsciiArt
  class Error < StandardError; end

  image = MiniMagick::Image.open('images/ascii-pineapple.jpg')

  length, width = image.dimensions

  puts 'Successfully constructed pixel matrix!'
  puts "Pixel matrix size: #{length} x #{width}"

  puts 'Iterating through pixel contents'
  image.get_pixels.each do |group|
    group.each { |pixel| p pixel }
  end
end
