class ActivityType < ApplicationRecord
    belongs_to :activity

    enum title: [:lecture, :workshop, :talking_circle]
end
