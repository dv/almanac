# == Schema Information
#
# Table name: log_entries
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  data       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class AlmanacEntry < ActiveRecord::Base
  attr_accessible :title, :data
  serialize :data

  has_many :almanac_tags

  def self.log(title, data = nil)
    almanac_entry = AlmanacEntry.create(title: title, data: data)
  end

  def tag(*params)
    params.each do |param|
      if param.kind_of?(String) || param.kind_of?(Symbol)
        AlmanacLabel.find_or_create_by_name(param).almanac_entries << self
      elsif param != nil
        param.almanac_entries << self
      end
    end

    self
  end

  def tags
    self.almanac_tags.map(&:tag)
  end

  def tags=(*params)
    binding.pry
  end

  def self.for(param)
    if param.kind_of?(String) || param.kind_of?(Symbol)
      param = AlmanacLabel.find_by_name(param)
    end

    param.almanac_entries
  end

  def self.almanacabled(*models)
    models.each do |model|
      has_many model.name.to_sym,
        :through => :almanac_tags,
        :source => :tag,
        :source_type => model.to_s.singularize.capitalize
    end
  end
end
