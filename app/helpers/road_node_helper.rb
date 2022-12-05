# frozen_string_literal: true

class RoadNodeHelper
  def self.save_tree(root_node, parent_id = nil)
    children = root_node[:children]
    root_node[:parent_id] = parent_id
    node = RoadNode.new(root_node)
    children each do |child|
      save_tree(child, node.id)
    end

    true
  end
end
