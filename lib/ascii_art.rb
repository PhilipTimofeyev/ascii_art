# frozen_string_literal: true

require_relative 'ascii_art/version'
require 'mini_magick'

module AsciiArt
  class Error < StandardError; end

  image = MiniMagick::Image.open('images/ascii-pineapple.jpg')

  length, width = image.dimensions

  puts 'Successfully loaded image!'
  puts "Image size: #{length} x #{width}"
end
