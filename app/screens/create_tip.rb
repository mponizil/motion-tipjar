class CreateTip < PM::FormotionScreen
  title "Add a Tip"

  def on_create(args={})
    @tipjar = args[:tipjar]
    super
  end

  def on_load
    set_nav_bar_button :back, title: "Cancel", style: :plain, action: :back
  end

  def table_data
    {
      sections: [{
        title: "Add a Tip",
        rows: [{
          title: "Name",
          key: :name,
          placeholder: "Name of the Tip",
          type: :string
        }, {
          title: "Content",
          key: :content,
          placeholder: "What's your tip?",
          type: :text,
          row_height: 100
        }]
      }, {
        rows: [{
          title: 'Create',
          type: :submit
        }]
      }]
    }
  end

  def on_submit(form)
    data = form.render
    tip = Tip.new
    tip.name = data[:name]
    tip.content = data[:content]
    tip.author = PFUser.currentUser
    tip.tipjar = @tipjar.PFObject
    tip.location = User.current_user.location
    tip.saveInBackgroundWithBlock(lambda do |success, error|
      close
    end)
  end
end
