# frozen_string_literal: true

class EvidencesController < ApplicationController
  def destroy
    media = ActiveStorage::Attachment.find(params[:media_id])
    media.purge if media.record.errors.empty?
  rescue StandardError => e
    flash[:error] = "Sorry, image couldn't be upload"
    logger.error "LOG DE ERROR rescue #{media.inspect}"
    logger.error "Mensaje de exception #{e}"
  ensure
    redirect_back(fallback_location: request.referer)
  end
end
