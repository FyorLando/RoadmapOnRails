module RoadmapsModule
  class RoadNode < ApplicationRecord
    belongs_to :topic
    has_many :attachments

    def children
      RoadNode.find_each(parent_id: id)
    end

    def parent
      parent_id == nil ? nil : RoadNode.find_by_id(parent_id)
    end

    def is_root?
      parent_id == nil
    end
  end
end

