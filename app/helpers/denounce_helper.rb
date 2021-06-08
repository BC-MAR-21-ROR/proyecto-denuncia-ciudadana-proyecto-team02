# frozen_string_literal: true

module DenounceHelper
  def options_for_state_select
    State.names
  end

  def options_for_municipality_select(address)
    address ? Municipality.for(address.state).pluck(:name) : []
  end

  def options_for_settlement_select(address)
    address ? Settlement.for(address.municipality).pluck(:name) : []
  end
end
