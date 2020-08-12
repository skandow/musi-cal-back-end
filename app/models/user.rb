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

    def admined_events 
        admin_for.map do |ensemble|
            ensemble.events
        end.flatten
    end 

    def admined_user_events 
        admined_events.map do |event|
            event.user_events.map do |user_event|
                user_event.data 
            end 
        end.flatten 
    end

end
