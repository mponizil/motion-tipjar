class ViewTipjar < PM::TableScreen
  title 'View Tipjar'

  def on_create(args={})
    @tipjar = args[:tipjar]
    super
  end

  def on_load
    query = Tip.query
    query.whereKey('tipjar', equalTo: @tipjar.PFObject)
    query.find do |tips, error|
      @table_data = [{
        cells: tips.map do |tip|
          {
            title: tip.content,
            action: :view_tip,
            arguments: { tip: tip }
          }
        end
      }]

      update_table_data
    end
  end

  def will_appear
    set_nav_bar_button :back, title: 'Back', style: :plain, action: :back
    set_nav_bar_button :right, system_item: :add, action: :create_tip

    # This is a workaround for an iOS 7 issue.
    # Ref: https://github.com/clearsightstudio/ProMotion/issues/348
    self.navigationController.navigationBar.translucent = false
  end

  def table_data
    @table_data ||= []
  end

  def create_tip
    open CreateTip.new(tipjar: @tipjar)
  end

  def view_tip(args={})
    open ViewTip.new(tip: args[:tip])
  end
end
