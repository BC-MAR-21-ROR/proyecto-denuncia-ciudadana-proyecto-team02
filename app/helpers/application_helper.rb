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
end
