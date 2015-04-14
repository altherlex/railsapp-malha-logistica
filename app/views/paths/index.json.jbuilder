json.array!(@paths) do |path|
  json.extract! path, :id, :local, :begin_point, :end_point, :distance
  json.url path_url(path, format: :json)
end
