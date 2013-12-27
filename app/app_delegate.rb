Parse.setApplicationId('DFj5LmziltCjLAT2KLNeR4bbWoH1dAIon0xvttAf', clientKey: 'TDV6XAY1a3MXs0mtip5GtRl3aAHZJw3jmd14p2On')

class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    PFUser.enableAutomaticUser
    User.current_user.save

    PFGeoPoint.geoPointForCurrentLocationInBackground(lambda do |geo_point, error|
      User.current_user.location = geo_point
      User.current_user.saveInBackground
    end)

    open HomeScreen.new(nav_bar: true)
  end

end
