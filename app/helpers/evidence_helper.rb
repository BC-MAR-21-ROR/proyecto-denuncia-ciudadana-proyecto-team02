# frozen_string_literal: true

module EvidenceHelper

  def render_evidences(attachments)
    if attachments.count.positive?
      render_evidence_carousel_preview(attachments)
    else
      render_no_image
    end
  end

  def render_evidence_carousel_preview(attachments)
    attachments.each_with_index do |attachment, index|
      concat(
        content_tag(:div, class: "carousel-item #{'active' if index.zero?} img-carousel") do
          render_attachment(attachment, 'img-fluid img-thumbnail p-5')
        end
      )
    end
    return
  end

  def render_no_image
    image_tag('no-image.svg', class: 'img-fluid img-thumbnail p-5')
  end

  def render_attachment(attachment, styles)
    if attachment.image?
      image_tag(url_for(attachment), class: styles)
    else
      link_to(url_for(attachment)) do
        image_tag('pdf.svg', class: styles)
      end
    end
  end
end
