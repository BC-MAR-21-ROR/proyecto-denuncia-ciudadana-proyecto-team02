module LikesHelper
  def likeable?(likeable)
    current_user.nil? || current_user.like?(likeable).nil?
  end

  def like_link_for(likeable)
    options = {
      method: :post,
      id: "create-like-#{likeable.id}",
      class: 'btn btn-link my-2',
      remote: true
    }
    link_to likes_path(likeable_id: likeable.id, likeable_type: likeable.class.name), options do
      content_tag(:i, nil, class: 'bi bi-hand-thumbs-up')
    end
  end

  def unlike_link_for(likeable)
    options = {
      method: :delete,
      id: "destroy-like-#{likeable.id}",
      class: 'btn btn-link my-2',
      remote: true
    }
    link_to like_path(current_user.like?(likeable)), options do
      content_tag(:i, nil, class: 'bi bi-hand-thumbs-up-fill')
    end
  end
end
