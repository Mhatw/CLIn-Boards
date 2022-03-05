
module Validations

  def valid_list_id(id)
    valid = false
    $global_data.each { |n| valid = true if n["id"] == id.to_i }
    valid
  end

  def valid_list_name(action, id_list)
    valid = false
    $global_data[id_list]["lists"].each { |n| valid = true if n["name"] == action }
    valid
  end

  

end