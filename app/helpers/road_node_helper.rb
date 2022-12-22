# frozen_string_literal: true

class RoadNodeHelper
  def self.genTreeResponse(all_nodes, id = nil)
    current_node = all_nodes.where(:id => id)[0].attributes
    children = all_nodes.where(:parent_id => id).to_a

    children_array = []

    children.each do |child|
      children_array.push(self.genTreeResponse(all_nodes, child["id"]))
    end

    current_node[:children] = children_array
    current_node[:attachments] = RoadmapsModule::Attachment.where(:node_id => id)

    current_node
  end

  def self.removeRecursively(node_id)
    children = RoadmapsModule::RoadNode.where(:parent_id => node_id)

    children.each do |child|
      self.removeRecursively(child.id)
      child.destroy
    end
  end
end
