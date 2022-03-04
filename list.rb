class List

  def initialize(id)
    @id = id
    @pos = ""
    $global_data.each { |n| @pos = n if n["id"] == id.to_i }
    @pos
  end

  def show_list

  end

  

end