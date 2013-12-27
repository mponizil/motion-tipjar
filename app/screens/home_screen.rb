class HomeScreen < PM::TableScreen
  include HomeStyles

  title 'Home'

  refreshable callback: :on_refresh,
    pull_message: "Pull to refresh",
    refreshing: "Refreshing data...",
    updated_format: "Last updated at %s",
    updated_time_format: "%l:%M %p"

  def on_load
    @view_setup ||= self.set_up_view

    fetch do
      update_table_data
    end
  end

  def on_refresh
    fetch do
      end_refreshing
      update_table_data
    end
  end

  def will_appear
    set_nav_bar_button :right, system_item: :add, action: :create_tipjar
  end

  def set_up_view
    true
  end

  def fetch(&block)
    query = Tipjar.query
    query.whereKey('users', equalTo: PFUser.currentUser)
    query.find do |tipjars, error|
      @table_data = [{
        cells: tipjars.map do |tipjar|
          {
            title: tipjar.name,
            action: :view_tipjar,
            arguments: { tipjar: tipjar }
          }
        end
      }]

      block.call if block
    end
  end

  def table_data
    @table_data ||= []
  end

  def create_tipjar
    open CreateTipjar
  end

  def view_tipjar(args={})
    open ViewTipjar.new(tipjar: args[:tipjar])
  end
end
