class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    Parse.setApplicationId(PARSE_APPLICATION_ID, clientKey: PARSE_CLIENT_ID)

    PFUser.enableAutomaticUser
    User.current_user.save if User.current_user.objectId.nil?

    PFGeoPoint.geoPointForCurrentLocationInBackground(lambda do |geo_point, error|
      User.current_user.location = geo_point
      User.current_user.saveInBackground
    end)

    open HomeScreen.new(nav_bar: true)
  end

end
