class Crease < ApplicationRecord
  include AASM
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_many :participants
  has_many :users, through: :participants

  validates :title, :link, :description, presence: true
  validates :title, length: { maximum: 300 }
  validates :recommended_quantity, format: { with: /\A\d+\z/, message: 'Неверный формат. Введите число' }
  validates :amount, format: { with: /\A\d+\z/, message: 'Неверный формат. Введите число' }

  aasm column: 'state' do
    state :proposed, initial: true
    state :approved
    state :rejected
    state :active
    state :canceled
    state :finished

    event :reject do
      transitions from: [:proposed], to: :rejected
    end

    event :verify do
      transitions from: [:proposed], to: :approved
    end

    event :activate do
      transitions from: [:approved], to: :active
    end

    event :inactive do
      transitions from: [:active], to: :approved
    end

    event :cancel do
      transitions from: [:active], to: :canseled
    end

    event :finish do
      transitions from: [:active], to: :finished
    end

    event :unfinish do
      transitions from: [:finished], to: :active
    end
  end
end
