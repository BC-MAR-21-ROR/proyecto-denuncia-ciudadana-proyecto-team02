# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_bootstrap(type)
    {
      'error' => :danger,
      'notice' => :info,
      'alert' => :warning,
      'success' => :success
    }.fetch(type, 'notice')
  end
end
