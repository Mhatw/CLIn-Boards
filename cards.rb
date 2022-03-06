def update_card(found_board, id)
  card_found, id = find_card(found_board, id)
  list_found = found_board.lists.find { |list| list.cards.find { |card| card == card_found } }
  delete_card(found_board, id)
  card_hash, list_name = update_card_form(found_board, id.to_i)
  list_chosen = found_board.lists.find { |list| list.name == list_name }
  list_chosen.update_card(card_hash, id.to_i)
end
def find_card(found_board, id)
  found_card = found_board.lists.map do |list|
    list.cards.find { |card| card.id == id.to_i }
  end
  found_card.compact!
  while found_card[0].nil?
    puts "Invalid ID!"
    print "Id: "
    id = gets.chomp
    found_card = found_board.lists.map do |list|
      list.cards.find { |card| card.id == id.to_i }
    end
    found_card.compact!
    # p found_card[0]
  end
  [found_card[0], id.to_i]
end
def update_card(hash, id)
  card_found = @cards.find { |card| card.id == id.to_i }
  if card_found.nil?
    create_card(hash)
  else
    index = @cards.index(card_found)
    @cards[index] = Card.new(hash)
  end
end