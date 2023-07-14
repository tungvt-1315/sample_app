# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  
  def full_title page_title
    base_title = t "title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
