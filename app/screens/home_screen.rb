class HomeScreen < PM::Screen

  def on_load
    open_tab_bar MyTipjars.new(nav_bar: true), BrowseTipjars.new(nav_bar: true)
  end

end
