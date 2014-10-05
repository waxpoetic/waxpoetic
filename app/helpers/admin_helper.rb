# Calculate routes of different resources.
module AdminHelper
  def resource_path(route_name)
    send "#{route_name}_path"
  end

  def new_resource_path(route)
    send "new_#{route.to_s.singularize}_path"
  end

  def edit_resource_path(route, model)
    send "edit_#{route.to_s.singularize}_path", model
  end
end
