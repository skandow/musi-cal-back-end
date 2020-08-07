class Membership < ApplicationRecord
    belongs_to :user
    belongs_to :ensemble
    validates :user_id, uniqueness: { scope: :ensemble_id }

    def membership_data 
        {
            id: self.id,
            ensemble_id: self.ensemble_id,
            admin: self.admin,
            image_url: user.image_url,
            user: self.user.name,
            email: self.user.email,
            phone_number: self.user.phone_number,
            performing_roles: self.performing_roles,
            administrative_roles: self.administrative_roles
        }
    end
end


