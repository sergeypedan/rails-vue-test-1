# frozen_string_literal: true

class Record < ApplicationRecord

  # Associations

  belongs_to :artist
  belongs_to :user

  # Validations

  validates :title, :year, presence: true

end

# == Schema Information
# Schema version: 20200502163625
#
# Table name: records
#
#  id        :integer          not null, primary key
#  title     :string           not null
#  year      :integer          not null
#  artist_id :integer          not null
#  user_id   :integer          not null
#
# Indexes
#
#  index_records_on_artist_id  (artist_id)
#  index_records_on_user_id    (user_id)
#
# Foreign Keys
#
#  artist_id  (artist_id => artists.id)
#  user_id    (user_id => users.id)
#
