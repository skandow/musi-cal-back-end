class MembershipsController < ApplicationController
    def create
        membership = Membership.new(membership_params)
        user = User.find_by(email: params[:email])
        membership.user_id = user.id 
        membership.save
        if membership.valid?
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
        membership.destroy 
        render json: { user: UserSerializer.new(current_user) }
    end 

    private 

    def membership_params
        params.require(:membership).permit(:ensemble_id, :admin, :performing_roles, :administrative_roles)
    end 
end
