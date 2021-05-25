class MunicipalitiesController < ApiController
  def index
    @state = State.find_by(name: params[:state])
    render json: @state.municipalities
  end
end