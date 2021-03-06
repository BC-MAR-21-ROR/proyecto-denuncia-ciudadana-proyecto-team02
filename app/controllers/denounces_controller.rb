# frozen_string_literal: true

class DenouncesController < ApplicationController
  before_action :set_denounce, only: %i[edit update destroy]
  before_action :authenticate_user!

  # GET /denounces
  def index
    @pagy, @denounces = pagy(current_user.denounces.includes(:address).order(created_at: :desc), items: 10)
  end

  # GET /denounces/1
  def show
    @denounce = Denounce.find(params[:id])
  end

  # GET /denounces/new
  def new
    @denounce = Denounce.new
    @address = Address.new
  end

  # GET /denounces/1/edit
  def edit
    @address = @denounce.address
  end

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
    @denounce = current_user.denounces.includes(medias_attachments: :blob).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def denounce_params
    params.require(:denounce).permit(
      :event_date,
      :area,
      :title,
      :description,
      :anonymouse,
      address_attributes: %i[id state municipality settlement postal_code street number],
      medias: []
    )
  end
end
