class Crease < ApplicationRecord
  include AASM

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

  has_many :participants
  has_many :users, through: :participants
end
