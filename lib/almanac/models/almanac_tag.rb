# == Schema Information
#
# Table name: almanac_tags
#
#  id           :integer         not null, primary key
#  almanac_entry_id :integer
#  tag_id   :integer
#  tag_type :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class AlmanacTag < ActiveRecord::Base
  belongs_to :tag, :polymorphic => true
  belongs_to :almanac_entry
  
end
