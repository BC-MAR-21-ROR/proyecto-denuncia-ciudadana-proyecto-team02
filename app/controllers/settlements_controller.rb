class SettlementsController < ApiController
  def index
    @municipality = Municipality.find_by(name:params[:municipality])
    render json: @municipality.settlements.order(name: :asc).distinct if !params[:municipality].nil?
  end

  def show
    render json: Settlement.where(postal_code: params[:postal_code]).distinct
  end
end
