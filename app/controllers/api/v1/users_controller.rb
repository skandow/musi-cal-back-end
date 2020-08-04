class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: token }, status: :created 
        else 
            render json: { error: 'failed to create user'}, status: :not_acceptable
        end
    end
    
    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def update 
        user = User.find(params[:id])
        user.update(user_params)
        if user.valid?
            render json: UserSerializer.new(user)
        else 
            render json: { error: 'failed to update '} 
        end 
    end 

    def destroy 
        user = User.find(params[:id])
        user.destroy 
        render json: UserSerializer.new(user)
    end 

    private
    def user_params
        params.require(:user).permit(:name, :password, :phone_number, :email, :primary_instrument_or_voice_part, :secondary_instrument, :image_url)
    end
end
