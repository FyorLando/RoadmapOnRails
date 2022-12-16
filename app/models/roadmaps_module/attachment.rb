module RoadmapsModule
  class Attachment < ApplicationRecord
    belongs_to :road_node, :foreign_key => 'node_id'
  end

end