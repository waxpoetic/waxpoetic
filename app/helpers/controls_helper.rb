module ControlsHelper
  def resource_path(resource)
    send "#{kind_of(resource)}_path", resource
  end

  def edit_resource_path(resource)
    send "edit_#{kind_of(resource)}_path", resource
  end

  def resource_if_available
    try(:artist) || try(:release)
  end

  def admin_controls(collection_name, resource: resource)
    for_kind = collection_name.singularize
    case controller.action_name
    when 'index'
      new_item_button for_kind
    when 'show'
      render 'controls', resource: resource, kind: for_kind
    end
  end

  def new_item_button(kind)
    route = send("new_#{kind.downcase}_path")
    link_to "New #{kind}", route, class: 'button secondary'
  end



  private
  def kind_of(resource)
    resource.class.name.tableize.singularize
  end
end
