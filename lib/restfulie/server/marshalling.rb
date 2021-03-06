
module Restfulie
  
  module Server
  
    module Marshalling
  
      def to_json
        super :methods => :following_states
      end
  
      # adds a link for each transition to the current xml writer
      def add_links(xml, all, options)
        all.each do |transition|
          add_link(transition, xml, options)
        end
      end

      # adds a link for this transition to the current xml writer
      def add_link(transition, xml, options) 

        transition = self.class.existing_transitions(transition.to_sym) unless transition.kind_of? Restfulie::Server::Transition
        transition.add_link_to(xml, self, options)

      end

      def to_xml(options = {})
    
        transitions = all_following_transitions
        return super(options) if transitions.empty? || options[:controller].nil?
    
        options[:skip_types] = true
        super options do |xml|
          add_links xml, transitions, options
        end
      end
  
    end

  end  
end
