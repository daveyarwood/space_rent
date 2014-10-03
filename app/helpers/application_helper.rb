module ApplicationHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      page_title = content_for?(:title) ? "#{content_for :title} :: " : ""
      default_title = "spacerent v#{SpaceRent::Application::VERSION}"
      page_title + default_title
    end
  end
end
