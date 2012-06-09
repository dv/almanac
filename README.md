Almanac
=======

This project rocks and uses MIT-LICENSE.

Usage
=====

Call acts_as_almanacable in every model you want to put in the almanac:

class User < ActiveRecord::Base
  acts_as_almanacable
end

If you want to log changes to the model automatically, also known as auditing, pass it in as an option:

  acts_as_almanacable :audit => true

If you want to exclude certain attributes from being audited:

  acts_as_almanacable :audit => true, :except => [:last_signed_in_time, :last_signed_in_ip]

You can log things in the almanac as follows:

  AlmanacEntry.new(:title => "User signed up").save

Or shortened

  Almanac.log("User signed up", data)

Data is an optional object (mostly hash, but arrays and other things are possible too) that will be saved together with the title.

You can then add any activerecord instance to it by tagging

  AlmanacEntry.log("User signed up").tag(subscription.find(param[:id]))

Or add some labels to it, which are just regular strings

  almanac_entry = AlmanacEntry.log("User signed up")
  almanac_entry.tag("api", :user, subscription)
  almanac_entry.tags << plan << user

You can also log straight away on ActiveRecord objects:

  subscription = Subscription.create()
  subscription.log("Activated")

You can easily return the almanac entries for a certain object:

  subscription.almanac_entries
  AlmanacEntry.for(subscription)

Or for a Label (string or symbol):

  AlmanacLabel.find_by_name("api").almanac_entries
  AlmanacEntry.for("api")


Controllers
-----------

You can use almanac to log certain requests. The params hash will be automatically added as metadata.

class PostsController < ApplicationController
  before_filter :almanac_request

end

If current_user is defined, the request will automatically be tagged with the user if the user is
almanacable.

You can edit the entry, or tag the logged request with other objects as well by using the @almanac and @almanac_tags object:

around_filter :almanac_request

def show
  subscription = Subscription.find(params[:id])
  @almanac.title = "New Title"
  @almanac_tags << subscription

end

If you want to abort you can assign nil to @almanac.

Resources
---------

* http://api.rubyonrails.org/classes/ActiveSupport/Concern.html
* https://github.com/darcy/acts_as_loggable/blob/master/lib/acts_as_loggable.rb
* http://guides.rubyonrails.org/generators.html
* http://guides.rubyonrails.org/plugins.html
* http://www.engineyard.com/blog/2010/extending-rails-3-with-railties/