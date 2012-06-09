# == Schema Information
#
# Table name: almanac_labels
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class AlmanacLabel < ActiveRecord::Base
  acts_as_almanacable

  attr_accessible :name
end
