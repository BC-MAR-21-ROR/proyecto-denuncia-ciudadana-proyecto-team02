module EvidenceHelper
  def render_evidence_carousel_images(images)
    images.each_with_index do |image, index|
      concat(
        content_tag(:div, class: "carousel-item #{'active' if index.zero?}") do
          if image.image?
            image_tag(url_for(image), class: 'img-fluid img-thumbnail')
          else
            content_tag(:i, nil, class: 'bi bi-card-image')
          end
        end
      )
    end
    return
  end
end
