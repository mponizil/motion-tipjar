class MyTipjars < PM::TableScreen

  title "My Tipjars"
  tab_bar_item icon: 'favorites', title: "Mine"
  refreshable callback: :on_refresh,
    pull_message: "Pull to refresh",
    refreshing: "Refreshing data...",
    updated_format: "Last updated at %s",
    updated_time_format: "%l:%M %p"

  def on_refresh
    fetch do
      end_refreshing
      update_table_data
    end
  end

  def on_load
    set_nav_bar_button :right, system_item: :add, action: :create_tipjar
  end

  def on_appear
    fetch do
      update_table_data
    end
  end

  def fetch(&block)
    query = Tipjar.query
    query.whereKey('author', equalTo: PFUser.currentUser)
    query.find do |tipjars, error|
      @table_data = [{
        cells: tipjars.map do |tipjar|
          {
            title: tipjar.name,
            action: :view_tipjar,
            arguments: { tipjar: tipjar },
            editing_style: :delete
          }
        end
      }]

      block.call if block
    end
  end

  def on_cell_deleted(cell)
    tipjar = cell[:arguments][:tipjar]
    if tipjar.author.objectId == PFUser.currentUser.objectId
      tipjar.deleteInBackground
    else
      relation = tipjar.relationforKey('users')
      relation.removeObject(PFUser.currentUser)
      tipjar.saveInBackground
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
