# Calculate routes of different resources, and provide generic helper
# methods for displaying the admin control panels.
module AdminHelper
  # Generate the route path to the given resource.
  def resource_path(*arguments)
    send "#{resource_name}_path", *arguments
  end

  # Generate the route path to the resource's new form.
  def new_resource_path
    send "new_#{resource_name}_path"
  end

  # Generate the route path to the resource's edit form.
  def edit_resource_path(model)
    send "edit_#{resource_name}_path", model
  end

  # Calculate the current resource name from its controller.
  def resource_name
    controller.controller_name.singularize
  end

  # Attempt to find a resouce
  def current_resource
    resources.find { |model| try model }
  end

  def admin_controls(collection_name, resource: nil, kind: collection_name.singularize)
    case controller.action_name
    when 'index'
      new_item_button
    when 'show'
      render 'controls', resource: resource, kind: kind
    end
  end

  def new_item_button
    link_to "New #{resource_name.titleize}", new_resource_path, class: 'button secondary'
  end

  private

  def resources
    %i(release track event)
  end
end
