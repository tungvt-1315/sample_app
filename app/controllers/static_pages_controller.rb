# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @page, @feed_items = pagy current_user.feed
  end

  def help; end
end
