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

    rates_array = RatesModule::NodeRate.where(:node_id => id)
    count_rates = rates_array.size();
    current_node[:rates] = rates_array;
    current_node[:ave_rate] = count_rates>0?(
                               rates_array.inject(0){|result, elem| result = result + elem[:rate]}*1.0/count_rates):nil;

    current_node
  end
end
