class Message < ApplicationRecord
  belong_to :group
  belong_to :user

  validates :text,presence: true,unless: :image?
end
