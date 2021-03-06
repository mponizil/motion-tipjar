class CreateTipjar < PM::FormotionScreen
  title 'Create Tipjar'

  def on_load
    set_nav_bar_button :back, title: "Cancel", style: :plain, action: :back
  end

  def table_data
    {
      sections: [{
        title: "Create Tipjar",
        rows: [{
          title: "Name",
          key: :name,
          placeholder: "Name of the Tipjar",
          type: :string
        }]
      }, {
        rows: [{
          title: "Create",
          type: :submit
        }]
      }]
    }
  end

  def on_submit(form)
    data = form.render
    tipjar = Tipjar.new
    tipjar.name = data[:name]
    tipjar.author = PFUser.currentUser
    tipjar.location = User.current_user.location
    relation = tipjar.relationforKey('users')
    relation.addObject(PFUser.currentUser)
    tipjar.saveInBackgroundWithBlock(lambda do |success, error|
      close
    end)
  end
end
