class Match < ActiveRecord::Base
  belongs_to :user
  belongs_to :other_user, class_name: 'User'
  scope :matched, -> { where(match: true) }
end
