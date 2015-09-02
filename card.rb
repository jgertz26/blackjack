class Card
  attr_reader :suit, :value, :all
  attr_accessor :num_value

  def initialize(value, suit)
    @value = value
    @suit = suit
    @all = value + suit
    @num_value = nil
  end

  def face_card?
    return @value == "J" || @value == "Q" || @value == "K" ? true : false
  end

end
