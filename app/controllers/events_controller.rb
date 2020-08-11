class EventsController < ApplicationController
    def create
        event = Event.create(event_params)
        if event.valid?
            memberships = event.ensemble.memberships
            memberships.each do |membership| 
            UserEvent.create(
                user_id: membership.user_id,
                event_id: event.id,
                attending: "undeclared",
                attended: false
            )
        end 
            render json: {user: UserSerializer.new(current_user) }
        else 
            render json: { error: 'failed to create event'}, status: :not_acceptable
        end 
    end 

    def update 
        event = Event.find(params[:id])
        event.update(event_params)
        if event.valid?
            render json: { user: UserSerializer.new(current_user)}
        else 
            render json: { error: 'failed to update event'}, status: :not_acceptable
        end 
    end 

    def destroy 
        event = Event.find(params[:id])
        event.destroy 
        render json: { user: UserSerializer.new(current_user) }
    end 

    private 

    def event_params
        params.require(:event).permit(:title, :start_time, :end_time, :place, :description, :ensemble_id, :mandatory)
    end 
end
