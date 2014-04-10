class BrowseTipjars < PM::TableScreen

  title "Browse"
  tab_bar_item icon: 'search', title: "Browse"
  searchable placeholder: "Search"
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

  def on_appear
    fetch do
      update_table_data
    end
  end

  # TODO: give me last 10 sorted by geo
  def fetch(&block)
    query = Tipjar.query
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
