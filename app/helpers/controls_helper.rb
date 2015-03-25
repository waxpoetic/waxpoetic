module ControlsHelper
  def resource_path(model)
    send "#{kind_of(model)}_path", model
  end

  def edit_resource_path(model)
    send "edit_#{kind_of(model)}_path", model
  end

  def and_resource_if_available
    try(:artist) || try(:release)
  end

  def admin_controls(collection_name, model)
    for_kind = collection_name.singularize
    case controller.action_name
    when 'index'
      new_item_button for_kind
    when 'show'
      render 'controls', resource: for_resource, kind: for_kind
    end
  end

  def new_item_button(kind)
    route = send("new_#{kind.downcase}_path")
    link_to "New #{kind}", route, class: 'button secondary'
  end

  private
  def kind_of(model)
    model.class.name.tableize.singularize
  end
end
