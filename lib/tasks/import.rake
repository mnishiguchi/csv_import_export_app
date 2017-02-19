require "csv"

namespace :import do
  desc "Import users from csv"
  task users: :environment do                     # Tell Rake to load the Rails app because we want to access User model.
    filename = File.join Rails.root, "users.csv"  # The absolute path to the CSV file.
    user_count = 0                                # Count the number of users that were successfully persisted to database.

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      # p row.to_hash

      # Crete a user in memory.
      user = User.new(row.to_hash.slice(:email, :username, :password))

      # Try to save it in the database.
      if user.save
        user_count += 1
      else
        puts "#{row["email"]} - #{user.errors.full_messages.join(', ')}"
      end
    end

    puts "Imported #{user_count} users"
  end
end
