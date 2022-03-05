module GetInput
  def get_input(prompt)
    input = ""
    while input.empty?
      print prompt
      input = gets.chomp
    end
    input
  end

  def get_action_board
    # arr = ["create", "show ID", "update ID", "delete ID"]
    puts "Board options: create | show ID | update ID | delete ID\nexit"
  end

  def get_action_lists
    puts "List options: create-list | update-list LISTNAME | delete-list LISTNAME\nCard options: create-card | checklist ID | update-card ID | delete-card ID\nback"
  end

  def get_id(data)
    data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(\d)$/).nil? ? "no" : data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(\d)$/)[1]
  end

  def get_list_action(data)
    data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s([a-zA-Z]+)$/).nil? ? "no" : data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s([a-zA-Z]+)$/)[1]

  end

end