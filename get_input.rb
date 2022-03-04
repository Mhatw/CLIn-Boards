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

  def get_id(data)
    data.match(/\d+/).nil? ? "no" : data.match(/\d+/)[0]
  end
end