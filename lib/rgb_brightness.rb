module RgbBrightness
  module_function

  def luminosity(pixel)
    (0.21 * pixel[0] + 0.72 * pixel[1] + 0.07 * pixel[2]) / 3
  end

  def lightness(pixel)
    (pixel.max + pixel.min) / 2
  end

  def average(pixel)
    pixel.sum / 3
  end

  ALGOS = { 1 => method(:average), 2 => method(:lightness),
            3 => method(:luminosity) }.freeze

  def get_algo(algo_num)
    ALGOS[algo_num]
  end
end
