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

  def get_action_checklist
    puts "Checklist options: add | toggle INDEX | delete INDEX\nback"
  end

  def empty_message
    (puts "\n#{"-"*36}\nyou don't have lists\nplease create-list\n#{"-"*36}\n\n")
  end

  def empty_card_message
    (puts "\n#{"-"*36}\nplease select correct list\n#{"-"*36}\n\n")
  end

  def get_id(data)
    data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(\d)$/).nil? ? "no" : data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(\d)$/)[1]
  end

  def get_list_action(data)
    data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(.+)$/).nil? ? "no" : data.match(/^[a-zA-Z]+-?[a-zA-Z]+\s(.+)$/)[1]
  end

  def get_card_count(action, id_list)
    puts "#################################"
    value = []

    $global_data[id_list]["lists"].each { |n| (puts n["cards"]["id"]) if n["name"] == action  }

    # p value
    # value.empty? ? value = 1 : value = value.last.to_i + 1
    # p value
    # value
  end

end