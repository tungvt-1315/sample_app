class StaticPagesController < ApplicationController
  def home
    @zone = "hello i am zone"
    @date = Date.today
  
  end

  def help; end
end
