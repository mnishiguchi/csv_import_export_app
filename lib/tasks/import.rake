require "csv"

namespace :import do
  desc "Import users from csv"
  task users: :environment do                     # Tell Rake to load the Rails app because we want to access User model.
    filename = File.join Rails.root, "users.csv"  # The absolute path to the CSV file.
    user_count = 0                                # Count the number of users that were successfully persisted to database.

    CSV.foreach(filename) do |row|
      # p row
      email, username = row

      # Try to create a user record in the database.
      user = User.create(
        email:    email,
        username: username,
        password: "password"
      )

      # Print errors to termimal if any.
      if user.errors.any?
        puts "#{email} - #{user.errors.full_messages}"
      end

      # Update the counter.
      if user.persisted?
        user_count += 1
      end
    end

    puts "Imported #{user_count} users"
  end
end
