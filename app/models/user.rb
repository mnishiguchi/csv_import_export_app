# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Notifications that are sent to this user.
  has_many :notifications, foreign_key: :recipient_id

  has_many :forum_threads
  has_many :forum_posts

  # Return an in-memory user object created from a CSV row.
  def self.assign_from_row(row)
    # NOTE: Use User.first_or_initialize instead of User.new so that we can
    # handle both creating a new record and updating an existing record.
    user = User.where(email: row[:email]).first_or_initialize
    user.assign_attributes(
      row.to_hash.slice(:email, :username, :password)
    )
    user  # Return an in-memory user object.
  end

end
