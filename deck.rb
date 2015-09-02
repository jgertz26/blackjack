class Deck
  SUITS = ["♦", "♥", "♠", "♣"]
  VALUES = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  attr_accessor :all
  def initialize
    @all = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @all << Card.new(value, suit)
      end
    end
  end

  def count
    @all.length
  end

  def shuffle
    @all.shuffle!
  end

  def deal_one(hand)
    new_card = @all.pop
    hand.cards << new_card
    new_card
  end
end
