class HomeController < ApplicationController
  def index
    @pagy, @denounces = pagy(filtered_denounces.order(created_at: :desc), items: 4)
  end

  private

  def filtered_denounces
    if current_user&.postal_codes_by_place_of_interest&.any?
      Denounce.for_postal_code(current_user.postal_codes_by_place_of_interest)
    else
      Denounce.all
    end
  end
end
