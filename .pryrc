require_relative './lib/oystercard.rb'

card1 = Oystercard.new
card1.top_up(10)
puts "#{card1.balance}"

card2 = Oystercard.new(50)
puts "#{card2.balance}"
