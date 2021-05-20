class ApplicationRecordAws < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :provinces, reading: :provinces }
end
