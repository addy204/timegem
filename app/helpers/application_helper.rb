# frozen_string_literal: true

module ApplicationHelper
  def add_breadcrumb(title, path = nil)
    @breadcrumbs ||= []
    @breadcrumbs << { title:, path: }
  end

  def render_breadcrumbs
    return if @breadcrumbs.blank?

    breadcrumbs = @breadcrumbs.map do |breadcrumb|
      if breadcrumb[:path].present?
        if breadcrumb[:path].is_a?(Symbol)
          # Handle route helpers (e.g., :root_path)
          link_to(breadcrumb[:title], send(breadcrumb[:path]))
        else
          # Handle direct URL strings (e.g., "/categories/1")
          link_to(breadcrumb[:title], breadcrumb[:path])
        end
      else
        content_tag(:span, breadcrumb[:title])
      end
    end

    breadcrumbs.join(' > ').html_safe
  end
end
