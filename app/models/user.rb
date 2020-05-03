# frozen_string_literal: true

class User < ApplicationRecord

  has_secure_password

  # Associations

  has_many :records

  # Validations

  validates :email,           presence: true
  validates :password_digest, presence: true

end

# == Schema Information
# Schema version: 20200502163046
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#
