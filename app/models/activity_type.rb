class ActivityType < ApplicationRecord
    belongs_to :activity
    validates :title, presence: true
end