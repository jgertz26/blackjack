#!/usr/bin/env ruby
require "pry"
require_relative "card.rb"
require_relative "deck.rb"
require_relative "hand.rb"

def alter_ace(hand)
  if hand.score > 21
    hand.cards.each do |card|
      if card.num_value == 11
        card.num_value = 1
        break
      end
    end
  end
end

def assign_bj_values(deck)
  deck.all.each do |card|
    if card.face_card?
      card.num_value = 10
    elsif card.value == "A"
      card.num_value = 11
    else
      card.num_value = card.value.to_i
    end
  end
end


deck = Deck.new
player_hand = Hand.new
dealer_hand = Hand.new

assign_bj_values(deck)
deck.shuffle

new_card = nil
2.times do
  new_card = deck.deal_one(player_hand)
  puts "Player was dealt #{new_card.all}"
  sleep(0.7)
  new_card = deck.deal_one(dealer_hand)
end
puts "Dealer was dealt ?"
sleep(0.7)
puts "Dealer was dealt #{new_card.all}"

sleep(0.7)
puts
puts "Dealer's hand: ? #{dealer_hand.cards[1].all}"
puts "Your hand: #{player_hand.show_hand} (#{player_hand.score} points)"
puts
sleep(1.1)

input = "meh"

alter_ace(player_hand)
alter_ace(dealer_hand)

while player_hand.score <= 21 && input.downcase != "s"
  puts "Hit or stand (H/S)"
  input = gets.chomp
  puts

  if input.downcase == "h"
    new_card = deck.deal_one(player_hand)
    puts "Player hits"
    sleep(1.3)
    puts "Player was dealt #{new_card.all}"
  elsif input.downcase == "s"
    puts "Player stands"
  else
    puts "INVALID"
  end

  sleep(1)
  alter_ace(player_hand)

  puts "Player hand: #{player_hand.show_hand} (#{player_hand.score} points)"
  puts
  sleep(1.2)
end

bust = false
if player_hand.score > 21
  puts "Player busts... YOU LOSE!"
  bust = true
else
  puts "Dealer reveals hand: #{dealer_hand.show_hand} (#{dealer_hand.score} points)"
  sleep(1.8)
  while dealer_hand.score < 17
    puts "Dealer hits"
    new_card = deck.deal_one(dealer_hand)
    sleep(0.8)
    puts "Dealer was dealt #{new_card.all}"
    sleep(1.4)

    alter_ace(dealer_hand)

    puts "Dealer hand: #{dealer_hand.show_hand} (#{dealer_hand.score} points)"
    puts
    sleep(1.4)
  end

  if dealer_hand.score > 21
    puts "Dealer busts... YOU WIN!"
    bust = true
  end
end

unless bust

  puts "Dealer stands"
  puts
  sleep(1)
  puts "Player final score: #{player_hand.score}"
  puts "Dealer final score: #{dealer_hand.score}"
  sleep(1.3)
  puts
  if dealer_hand.score == player_hand.score
    puts "PUSH!"
  elsif dealer_hand.score > player_hand.score
    puts "YOU LOSE!"
  else
    puts "YOU WIN!"
  end
end
