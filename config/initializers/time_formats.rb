Time::DATE_FORMATS[:readable_date] = lambda { |time| time.strftime("%a , %B %d, %Y at %H:%M") }
Time::DATE_FORMATS[:short_readable] = lambda { |time| time.strftime("%b %d, %Y at %H:%M") }

Date::DATE_FORMATS[:readable_date] = lambda { |time| time.strftime("%a , %B %d, %Y at %H:%M") }
Date::DATE_FORMATS[:short_readable] = lambda { |time| time.strftime("%b %d, %Y at %H:%M") }
