class PlaceOfInterestsController < ApplicationController
  before_action :set_place_of_interest, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /place_of_interests or /place_of_interests.json
  def index
    # @place_of_interests = PlaceOfInterest.all
    @place_of_interests = current_user.place_of_interest.all
  end

  # GET /place_of_interests/1 or /place_of_interests/1.json
  def show
  end

  # GET /place_of_interests/new
  def new
    @place_of_interest = PlaceOfInterest.new
  end

  # GET /place_of_interests/1/edit
  def edit
  end

  # POST /place_of_interests or /place_of_interests.json
  def create
    @place_of_interest = current_user.place_of_interest.build(place_of_interest_params)
    if @place_of_interest.save
      redirect_to place_of_interests_path, flash: { notice: 'Place of interest was successfully created.' }
    else
      flash[:error] = "Sorry , place of interest can not be created."
      render :new
    end
  end

  # PATCH/PUT /place_of_interests/1 or /place_of_interests/1.json
  def update
    respond_to do |format|
      if @place_of_interest.update(place_of_interest_params)
        format.html { redirect_to @place_of_interest, notice: "Place of interest was successfully updated." }
        format.json { render :show, status: :ok, location: @place_of_interest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place_of_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /place_of_interests/1 or /place_of_interests/1.json
  def destroy
    @place_of_interest.destroy
    respond_to do |format|
      format.html { redirect_to place_of_interests_url, notice: "Place of interest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place_of_interest
      @place_of_interest = PlaceOfInterest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_of_interest_params
      params.require(:place_of_interest).permit(:postal_code, :settlement, :user_id)
    end
end
