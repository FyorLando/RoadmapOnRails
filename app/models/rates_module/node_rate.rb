module RatesModule
  class NodeRate < ActiveRecord::Base
    belongs_to :road_node, :class_name => 'RoadmapsModule::RoadNode', :foreign_key => 'node_id'
  end
end
