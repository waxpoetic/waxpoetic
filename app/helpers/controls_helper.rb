module ControlsHelper
  def resource_path(resource)
    send "edit_#{kind_of(resource)}_path", resource
  end

  def edit_resource_path(resource)
    send "#{kind_of(resource)}_path", resource
  end

  private
  def kind_of(resource)
    resource.class.name.tableize.singularize
  end
end
