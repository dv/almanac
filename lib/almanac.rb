require "rails"
require "active_record"
require "almanac/acts_as_almanacable"
require "almanac/application_controller"

require "almanac/models/almanac_entry"
require "almanac/models/almanac_label"
require "almanac/models/almanac_tag"

module Almanac
  def self.log(*args)
    AlmanacEntry.log(*args)
  end

  def self.entries
    AlmanacEntry.scoped
  end
end
