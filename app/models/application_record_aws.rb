class ApplicationRecordAws < ActiveRecord::Base
  self.abstract_class = true
  establish_connection Rails.application.credentials.provinces_database_url
end
