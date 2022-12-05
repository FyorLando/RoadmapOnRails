class RoadNode < ApplicationRecord
  has_one :topic

  def parent
    parent_id == nil ? nil : RoadNode.find_by_id(parent_id)
  end

  def is_root?
    parent_id == nil
  end
end
