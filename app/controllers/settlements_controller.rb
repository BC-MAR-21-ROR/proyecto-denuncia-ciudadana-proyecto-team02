class SettlementsController < ApiController
  def index
    @municipality = Municipality.find_by(name:params[:municipality])
    render json: @municipality.settlements.order(name: :asc).distinct if !params[:municipality].nil?
  end
end
