class MembershipsController < ApplicationController
    def create
        membership = Membership.new(membership_params)
        user = User.find_by(email: params[:email])
        membership.user_id = user.id 
        membership.save
        if membership.valid?
            events = membership.ensemble.events.filter do |event|
                event.start_time.to_time > Time.now
            end 
            events.each do |event| 
            UserEvent.create(
                user_id: membership.user_id,
                event_id: event.id,
                attending: "undeclared",
                attended: false
            )
        end 
            render json: {user: UserSerializer.new(current_user) }
        else 
            render json: { error: 'failed to create membership'}, status: :not_acceptable
        end 
    end 

    def update 
        membership = Membership.find(params[:id])
        membership.update(membership_params)
        if membership.valid?
            render json: { user: UserSerializer.new(current_user)}
        else 
            render json: { error: 'failed to update membership'}, status: :not_acceptable
        end 
    end 

    def destroy 
        membership = Membership.find(params[:id])
        events = membership.ensemble.events.filter do |event| 
            event.start_time.to_time > Time.now 
        end
        user_events = events.map do |event|
            event.user_events 
        end.flatten 
        this_memberships_user_events = user_events.filter do |user_event|
            user_event.user_id == membership.user_id 
        end 
        this_memberships_user_events.each do |event| 
            event.destroy 
        end 
        membership.destroy 
        render json: { user: UserSerializer.new(current_user) }
    end 

    private 

    def membership_params
        params.require(:membership).permit(:ensemble_id, :admin, :performing_roles, :administrative_roles)
    end 
end
