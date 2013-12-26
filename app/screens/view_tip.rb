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
      frame: [[20, 20], [280, 40]]
    }
    add UITextView.new, {
      text: @tip[:content],
      frame: [[20, 80], [280, 140]],
      editable: false,
      font: UIFont.alloc.initWithName('Arial', size: 16)
    }
    true
  end
end
