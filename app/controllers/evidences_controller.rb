# frozen_string_literal: true

class EvidencesController < ApplicationController

  def destroy
    begin
      media = ActiveStorage::Attachment.find(params[:media_id])
      if media.record.errors.empty?
        media.purge
        redirect_back(fallback_location: request.referer)
      else
        flash[:error] = "Sorry, image couldn't be upload"
      end
    rescue StandardError => e
      # logger.debug "LOG DE DEGUG rescue: #{@denounce.inspect}"
      logger.error "LOG DE ERROR rescue #{media.inspect}"
      logger.error "Mensaje de exception #{e}"
    end
  end

end