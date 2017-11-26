class Participant < ApplicationRecord
  belongs_to :crease
  belongs_to :user
end
