class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
    belongs_to :application
end
