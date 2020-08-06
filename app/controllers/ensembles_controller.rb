class EnsemblesController < ApplicationController
    def create
        ensemble = Ensemble.create(ensemble_params)
        if ensemble.valid?
            Membership.create(
                user_id: current_user.id,
                ensemble_id: ensemble.id,
                admin: true,
                performing_roles: "",
                administrative_roles: ""
            )
            render json: {user: UserSerializer.new(current_user) }
        else 
            render json: { error: 'failed to create ensemble'}, status: :not_acceptable
        end 
    end 

    def update 
        ensemble = Ensemble.find(params[:id])
        ensemble.update(ensemble_params)
        if ensemble.valid?
            render json: { user: UserSerializer.new(current_user) }
        else 
            render json: { error: 'failed to update' }
        end 
    end 

    def destroy 
        ensemble = Ensemble.find(params[:id])
        ensemble.destroy
        render json: { user: UserSerializer.new(current_user)}
    end 

    private 

    def ensemble_params
        params.require(:ensemble).permit(:name, :website, :email_contact, :phone_number, :description, :image_url)
    end 
end
