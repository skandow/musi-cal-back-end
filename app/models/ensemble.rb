class Ensemble < ApplicationRecord
    has_many :memberships, :dependent => :destroy
    has_many :users, through: :memberships
    has_many :events, :dependent => :destroy

    def admins
        self.memberships.select do |membership|
            membership.admin == true 
        end.map do |membership|
            membership.user 
        end 
    end 
end
