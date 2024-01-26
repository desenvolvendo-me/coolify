module ApplicationHelper
  def filter_q(query)
    (params[:q] ? params[:q].to_unsafe_h : {}).merge(role_eq: query)
  end

  def convert_to_id(resource)
    resource.to_s.parameterize.concat("-#{resource.id}")
  end

  def devise_page?
    devise_controller? && %w[sessions registrations passwords].include?(controller_name)
  end
end
