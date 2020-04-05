module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(searching_params)
      results = self.where nil
      searching_params.each do |key, value|
        if value.present?
          results = results.public_send("search_by_#{key}", value)
        end
      end
      results
    end
  end
end
