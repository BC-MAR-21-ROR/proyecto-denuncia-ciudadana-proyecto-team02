# Create settlements for a group of states
def create_state_data(states, settlements)
  states.each do |state_name|
    state = State.find_or_create_by(name: state_name)
    municipalities = settlements.sheet(state_name).parse(
      postal_code: 'd_codigo',
      municipality: 'D_mnpio',
      name: 'd_asenta'
    ).group_by { |settlement| settlement[:municipality] }
    municipalities.each do |municipality_name, settlements|
      municipality = Municipality.find_or_create_by(
        name: municipality_name,
        state: state
      )
      print '.'
      settlements.each { |s|
        s.delete(:municipality)
        s[:created_at] = Time.now
        s[:updated_at] = Time.now
      }
      municipality.settlements.insert_all(settlements)
    end
    puts "\nCreated municipalities and settlements for #{state_name} 🍺"
  end
end
task populate_database: :environment do
  unless Settlement.any?
    filename = Rails.root.join('docs', 'settlements.xlsx').to_s
    file = Roo::Spreadsheet.open(filename, extension: :xlsx)
    thr = []
    file.sheets.each_slice(8) do |array_states|
      thr << Thread.new { create_state_data(array_states, file) }
    end
    thr.each(&:join)
    puts "#{Settlement.count}  settlements created 🍻"
  end
end
