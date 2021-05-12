# frozen_string_literal: true

module ApplicationHelper
  def flash_bootstrap(type)
    {
      'error' => :danger,
      'notice' => :primary,
      'alert' => :warning,
      'success' => :success
    }.fetch(type, 'notice')
  end
end
