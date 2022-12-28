class TopicHelper
  def self.GenTopicsResponse(all_topics)
    topics = all_topics.to_a
    topics_array = []

    topics.each do |topic|
      topics_array.push(self.GenTopicResponse(topic))
    end

    topics_array
  end

  def self.GenTopicResponse(topic)
    resp = topic.attributes
    rates_array = RatesModule::TopicRate.where(:topic_id => topic["id"])
    count_rates = rates_array.size()
    resp[:rates] = rates_array
    resp[:ave_rate] = count_rates>0?(
     rates_array.inject(0){|result, elem| result = result + elem[:rate]}*1.0/count_rates):nil

     resp
  end
end
