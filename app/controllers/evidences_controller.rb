# frozen_string_literal: true

class EvidencesController < ApplicationController
  before_action :set_media

  def destroy
    if @media.record.valid?
      @media.purge
      flash[:success] = 'Evidence has been successfully deleted'
    end
  rescue StandardError => e
    flash[:error] = "Sorry evidence can't be deleted, please try again!"
    logger.error "LOG ERROR rescue #{@media.inspect}\nException message #{e} "
  ensure
    redirect_back(fallback_location: request.referer)
  end

  private

  def set_media
    @media = ActiveStorage::Attachment.find(params[:media_id])
  end
end
