class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :chats, dependent: :destroy  # Add this line

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { member: "member", admin: "admin" }  # Note the colon before role

  # Auto-generate name from first_name and last_name
  def name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}".strip
    else
      nickname.presence || email_address.split("@").first
    end
  end
end
