# frozen_string_literal: true

module ApplicationHelper
  def flash_bootstrap(type)
    {
      'error' => :danger,
      'notice' => :info,
      'alert' => :warning,
      'success' => :success
    }.fetch(type, 'notice')
  end

  def like_link_for(likeable)
    options = {
      method: :post,
      class: 'btn btn-link',
      title: 'like',
      'data-bs-toggle': :tooltip
    }
    link_to likes_path(likeable_id: likeable.id, likeable_type: likeable.class.name), options do
      content_tag(:i, nil, class: 'bi bi-hand-thumbs-up')
    end
  end

  def unlike_link_for(likeable)
    options = {
      method: :delete,
      class: 'btn btn-link',
      title: 'unlike',
      'data-bs-toggle': :tooltip
    }
    link_to like_path(current_user.like?(likeable)), options do
      content_tag(:i, nil, class: 'bi bi-hand-thumbs-up-fill')
    end
  end
end
