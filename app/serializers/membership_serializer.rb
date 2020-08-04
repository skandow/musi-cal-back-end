class MembershipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user, :ensemble, :admin, :performing_roles, :administrative_roles
end
