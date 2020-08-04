class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :phone_number, :primary_instrument_or_voice_part, :secondary_instrument, :image_url, :events, :memberships, :ensembles, :admin_for
end
