class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :ensemble, :start_time, :end_time, :place, :lat, :lng, :description, :mandatory
end
