require "csv"

namespace :import do
  desc "Import users from csv"
  task users: :environment do                     # Tell Rake to load the Rails app because we want to access User model.
    filename = File.join Rails.root, "users.csv"  # The absolute path to the CSV file.
    CSV.foreach(filename) do |row|
      # email, username = row
      p row
    end
  end
end
