class EnigmaEncoder

  def keys(key)
    key.split('').each_cons(2).map {|a,b| a + b}.join
  end
end
