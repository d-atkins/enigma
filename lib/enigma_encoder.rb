class EnigmaEncoder

  def keys(key)
    key.split('').each_cons(2).map {|a,b| a + b}
  end

  def offset(date)
    (date.to_i**2).to_s[-4..-1].split('')
  end

  def shift(keys, offset)
    keys.map.with_index do |key, index|
      key.to_i + offset[index].to_i
    end
  end
end
