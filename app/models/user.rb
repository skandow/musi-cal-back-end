class User < ApplicationRecord
    has_many :memberships, :dependent => :destroy
    has_many :ensembles, through: :memberships
    has_many :user_events, :dependent => :destroy
    has_many :events, through: :user_events 
    has_secure_password
    validates :email, uniqueness: { case_sensitive: false }

    def admin_for 
        admined_ensembles = self.memberships.select do |membership|
            membership.admin == true 
        end.map do |membership|
            membership.ensemble
        end
        admined_ensembles.sort_by(&:id)
    end 

    def admined_members 
        admin_for.map do |ensemble|
            sorted_memberships = ensemble.memberships.sort_by(&:created_at)
            sorted_memberships.map do |membership|
                membership.membership_data
            end 
        end.flatten
    end 

    def not_admin 
        self.memberships.select do |membership|
            membership.admin == false 
        end.map do |membership|
            membership.ensemble 
        end 
    end

    def admined_events 
        admin_for.map do |ensemble|
            ensemble.events
        end.flatten
    end 

end
