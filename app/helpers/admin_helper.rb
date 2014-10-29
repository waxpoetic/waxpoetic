# Calculate routes of different resources.
module AdminHelper
  def resource_path(route_name)
    send "#{route_name}_path"
  end

  def new_resource_path
    send "new_#{model_name}_path"
  end

  def edit_resource_path(model)
    send "edit_#{model_name}_path", model
  end

  def model_name
    controller.controller_name.singularize
  end
end
