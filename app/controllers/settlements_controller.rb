class SettlementsController < ApiController
  def index
    @municipality = Municipality.find_by(name:params[:municipality])
    render json: @municipality.settlements
  end
end