# Extend ActiveRecord::Base with loggable functionality
module Almanac
  module Acts
    module Almanacable
      def acts_as_almanacable(options = {})
        include InstanceMethods

        has_many :almanac_tags, :as => :tag
        has_many :almanac_entries, :through => :almanac_tags

        almanacable_audit if options[:audit]

        AlmanacEntry.almanacabled(self)
      end

    private

      # Log lifetime changes to the model
      def almanacable_audit
        include AuditableMethods

        before_create   { log_audit(:create) }
        before_update   { log_audit(:update) }
        before_destroy  { log_audit(:destroy) }
      end
    end

    module InstanceMethods
      def log(title, data = nil)
        AlmanacEntry.log(title, data).tag(self)
      end

      def acts_as_almanacable?
        true
      end
    end

    module AuditableMethods
      def log_audit(action, data = {})
        data[:subject] ||= self.to_s
        self.log("#{self.class.name}##{action.to_s.underscore}", self.changes.merge(data)).tag(:audit, action)
      end
    end
  end
end

class ActiveRecord::Base
  extend Almanac::Acts::Almanacable
end
