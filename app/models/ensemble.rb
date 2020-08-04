class Ensemble < ApplicationRecord
    has_many :memberships
    has_many :users, through: :memberships
    has_many :events

    def admins
        self.memberships.select do |membership|
            membership.admin == true 
        end.map do |membership|
            membership.user 
        end 
    end 
end
