class Tip
  include ParseModel::Model

  fields :tipjar, :author, :lat, :lng, :name, :content
end
