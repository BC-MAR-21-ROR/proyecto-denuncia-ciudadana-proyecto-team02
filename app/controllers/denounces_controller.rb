class DenouncesController < ApplicationController
  before_action :set_denounce, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /denounces
  def index
    @denounces = current_user.denounces.order(created_at: :asc)
  end

  # GET /denounces/1
  def show; end

  # GET /denounces/new
  def new
    @denounce = Denounce.new
  end

  # GET /denounces/1/edit
  def edit; end

  # POST /denounces
  def create
    @denounce = current_user.denounces.build(denounce_params)
    if @denounce.save
      redirect_to denounces_path, flash: { notice: 'Denounce was successfully created.' }
    else
      flash[:error] = "Sorry , denounce couldn't be created "
      render :new
    end
  end

  # PATCH/PUT /denounces/1
  def update
    if @denounce.update(denounce_params)
      redirect_to @denounce, notice: 'Denounce was successfully updated.'
    else
      flash[:error] = "Sorry, denounce couldn't be updated"
      render :edit
    end
  end

  # DELETE /denounces/1
  def destroy
    @denounce.destroy
    respond_to do |format|
      format.html { redirect_to denounces_url, notice: 'Denounce was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_denounce
    @denounce = Denounce.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def denounce_params
    params.require(:denounce).permit(:event_date, :area, :title, :description, :likes, :anonymouse)
  end
end
