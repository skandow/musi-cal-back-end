class UserEventsController < ApplicationController
    def update 
        user_event = UserEvent.find(params[:id])
        user_event.update(user_event_params)
        if user_event.valid?
            render json: { user: UserSerializer.new(current_user)}
        else 
            render json: { error: 'failed to update status'}, status: :not_acceptable
        end 
    end 

    private 
    
    def user_event_params 
        params.require(:user_event).permit(:attending, :attended)
    end 
end  