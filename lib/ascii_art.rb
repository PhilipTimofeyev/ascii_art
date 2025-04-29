# frozen_string_literal: true

require_relative 'ascii_art/version'
require 'optparse'
require_relative 'rgb_brightness'
require_relative 'process_image'

# Creates ASCII Art
module AsciiArt
  class Error < StandardError; end
  include RgbBrightness
  # include ProcessImage

  options = { algo: '1' }

  parser = OptionParser.new do |parser|
    parser.banner = "Usage: ruby #{File.basename(__FILE__)} [options] <path_to_file>"

    parser.on('--help', 'Display this help') do
      puts parser
      exit
    end
    parser.on('-p', '--path PATH', String, 'Path to the file') do |path|
      options[:path] = path
    end
    parser.on('-a', '--algo ALGO', String,
              'RGB averaging method-- 1: Average, 2: Lightness, 3: Luminosity') do |path|
      options[:algo] = path
    end
  end.parse!

  if options[:path].nil?
    puts 'Error: Please provide a file path to jpg.'
    puts parser
    exit
  end

  puts "Processing file: #{options[:path]} using #{options[:algo]}"

  # Open and resize image
  image = Image.new(options[:path])
  image.resize_image

  # Retrieve requested brightness algo
  algo_int = options[:algo].to_i
  algo = RgbBrightness.get_algo(algo_int)

  # Create output directory if it doesn't exist
  directory_name = 'output'
  Dir.mkdir(directory_name) unless File.exist?(directory_name)

  # write image to output
  ascii_image = image.build_ascii_image(algo)
  File.write("output/#{image.filename}_ascii.text", ascii_image.join("\n"))
end
