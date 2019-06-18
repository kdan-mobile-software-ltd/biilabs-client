class Trytes
  attr_reader :value

  def initialize(string)
    @value = string
    return if trytes?
    @value = ''
    string.each_char do |char|
      asciiValue = char.unpack('c*').first
      return if asciiValue > 255
      firstValue = asciiValue % 27
      secondValue = (asciiValue - firstValue) / 27
      tryte = trytes_chars[firstValue] + trytes_chars[secondValue]
      @value += tryte
    end
  end

  def to_string
    return value unless trytes?
    string = ''
    (0..(value.length - 1)).step(2) do |i|
      tryte = value[i] + value[i + 1]
      break if tryte == '99'
      firstValue = trytes_chars.index(tryte[0])
      secondValue = trytes_chars.index(tryte[1])
      decimalValue = firstValue + secondValue * 27
      string += decimalValue.chr
    end
    string
  end
  private

  def trytes_chars
    '9ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  end

  def trytes?
    return false unless value.kind_of? String
    return false unless /^[9A-Z]*$/.match(value)
    true
  end
end
