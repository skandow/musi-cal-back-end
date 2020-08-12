class UserEvent < ApplicationRecord
    belongs_to :user
    belongs_to :event

    def data 
        {
            id: self.id,
            name: self.user.name,
            user_id: self.user_id,
            event_id: self.event_id,
            attending: self.attending, 
            attended: self.attended 
        }
    end 
end
