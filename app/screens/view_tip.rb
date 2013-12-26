class ViewTip < PM::Screen

  title 'View Tip'

  def on_create(args={})
    @tip = args[:tip]
    super
  end

  def on_load
    set_attributes self.view, {
      background_color: UIColor.whiteColor
    }

    @view_is_set_up ||= self.set_up_view
  end

  def will_appear
    set_nav_bar_button :back, title: 'Back', style: :plain, action: :back

    # This is a workaround for an iOS 7 issue.
    # Ref: https://github.com/clearsightstudio/ProMotion/issues/348
    self.navigationController.navigationBar.translucent = false


  end

  def set_up_view

    add UILabel.new, {
      text: @tip[:name],
      text_alignment: UITextAlignmentCenter,
      frame: [[0, 20], [320, 40]]
    }

    add UITextView.new, {
      text: @tip[:content],
      frame: [[0, 80], [320, 140]],
      editable: false,
      font: UIFont.alloc.initWithName('Arial', size: 16)
    }

    show_map if @tip.location

    true
  end

  def show_map
    map_view = MKMapView.alloc.initWithFrame(CGRectMake(0, 240, 320, 265))
    map_view.showsUserLocation = true
    annotation = MapViewAnnotation.new(@tip.location)
    annotation.title = @tip.name
    map_view.addAnnotation(annotation)
    add map_view

    location = CLLocationCoordinate2D.new(@tip.location.latitude, @tip.location.longitude)
    region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.01, 0.01))
    map_view.setRegion(region)
  end
end
