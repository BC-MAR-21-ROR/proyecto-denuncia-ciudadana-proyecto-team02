class ApplicationRecordAws < ActiveRecord::Base
  self.abstract_class = true
  establish_connection ENV.fetch("PROVINCES_DATABASE_URL", "")
end
