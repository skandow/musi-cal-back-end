class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :ensemble, :start_time, :end_time, :place, :description, :mandatory
end
