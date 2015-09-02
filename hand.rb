class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def score
    total = 0
    @cards.each { |card| total += card.num_value }
    total
  end

  def show_hand
    info = []
    @cards.each { |card| info << (card.all) }
    info.join(" ")
  end
end
