module EvidenceHelper
  def render_evidence_carousel_images(images)
    images.each_with_index do |image, index|
      concat(
        content_tag(:div, class: "carousel-item #{'active' if index.zero?}") do
          image_tag(url_for(image), class: 'img-fluid img-thumbnail')
        end
      )
    end
  end
end
