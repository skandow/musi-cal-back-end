class EnsembleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :website, :phone_number, :email_contact, :description, :image_url, :memberships, :admins
end
