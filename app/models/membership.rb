class Membership < ApplicationRecord
    belongs_to :user
    belongs_to :ensemble
    validates :user_id, uniqueness: { scope: :ensemble_id }
end
