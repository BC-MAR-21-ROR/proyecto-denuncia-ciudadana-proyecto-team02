def create_state_data(states, settlements)
  states.each do |state_name|
    state = State.find_or_create_by(name: state_name)
    settlements.sheet(state_name).parse(
      postal_code: 'd_codigo',
      municipality: 'D_mnpio',
      settlement: 'd_asenta'
    ).each do |hash|
      municipality = Municipality.find_or_create_by(
        name: hash.fetch(:municipality),
        state: state
      )
      Settlement.find_or_create_by(
        postal_code: hash.fetch(:postal_code),
        name: hash.fetch(:settlement),
        municipality: municipality
      )
    end
  end
end
task populate_database: :environment do
  filename = Rails.root.join('docs', 'settlements.xlsx').to_s
  file = Roo::Spreadsheet.open(filename, extension: :xlsx)
  thr = []
  file.sheets.each_slice(8) do |array_states|
    thr << Thread.new { create_state_data(array_states, file) }
  end
  thr.each(&:join)
end
