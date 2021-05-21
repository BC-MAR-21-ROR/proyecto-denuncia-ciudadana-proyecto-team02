class DenouncesController < ApplicationController
  before_action :set_denounce, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /denounces
  def index
    @denounces = Denounce.all.order(created_at: :asc)
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
      render :new, flash: { error: "Sorry , denounce couldn't be created " }
    end
  end

  # PATCH/PUT /denounces/1
  def update
    respond_to do |format|
      if @denounce.update(denounce_params)
        format.html { redirect_to @denounce, notice: 'Denounce was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
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
