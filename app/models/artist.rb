# frozen_string_literal: true

class Artist < ApplicationRecord

  # Associations

  has_many   :records, dependent: :destroy
  belongs_to :user, optional: true

  # Validations

  validates :name, presence: true

end

# == Schema Information
# Schema version: 20200502163625
#
# Table name: artists
#
#  id      :integer          not null, primary key
#  name    :string           not null
#  user_id :integer
#
# Indexes
#
#  index_artists_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
