class UsersStation < ApplicationRecord
    belongs_to :user
    belongs_to :station
    # validates :new_notes, numericality: {only_integer: true}
    # attribute :new_notes, :integer, default: 0
end
