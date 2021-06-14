module EvidenceHelper

  def render_evidences(attachments)
    if attachments.count > 0
      render_evidence_carousel_preview(attachments)
    else
      render_no_image
    end
  end

  def render_evidence_carousel_preview(attachments)
    attachments.each_with_index do |attachment, index|
      concat(
        content_tag(:div, class: "carousel-item #{'active' if index.zero?}") do
          if attachment.image?
            image_tag(url_for(attachment), class: 'img-fluid img-thumbnail')
          else
            link_to(url_for(attachment)) do
              # byebug
              image_tag('pdf.svg', class: 'img-fluid img-thumbnail p-5')
            end
          end
        end
      )
    end
    return
  end
  
  def render_no_image
    image_tag('no-image.svg', class: 'img-fluid img-thumbnail p-5')
  end

  def render_evidences_edit(attachment)
    if attachment.image?
      image_tag(url_for(attachment), class: 'img-size')
    else
      link_to(url_for(attachment)) do
        image_tag('pdf.svg', class: 'img-size')
      end
    end
  end

end
