class MapViewAnnotation
  attr_accessor :title

  def initialize(location)
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = location.latitude
    @coordinate.longitude = location.longitude
  end

  def coordinate
    @coordinate
  end
end
