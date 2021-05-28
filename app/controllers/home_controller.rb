class HomeController < ApplicationController
  def index
    @denounces = Denounce.all.order(created_at: :asc)
  end
end
