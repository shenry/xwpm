class ComponentState
  class << self
    def valid_states
      states = subclasses
      states.delete(ComponentState::Invalid)
      states.collect { |s| s.new.name }
    end
  end
  
  def transition(event)
    Invalid.new
  end
  
  def to_s
    self.name
  end
  
  class Active < ComponentState
    def name
      "Active"
    end
    
    def transition(event)
      inventory_transition(event)
    end
  end
  
  class Inactive < ComponentState
    def name
      "Inactive"
    end
    
    def transition(event)
      case event
      when ComponentEvent::Reactivate; Active.new
      else; Invalid.new
      end
    end
  end
  
  class Invalid < ComponentState
    def name
      "Invalid"
    end
  end
  
  private
  
  def inventory_transition(event)
    case event
    when ComponentEvent::Receive; Active.new
    when ComponentEvent::Deplete; Active.new
    when ComponentEvent::Adjust; Active.new
    when ComponentEvent::Deactivate; Inactive.new
    else; Invalid.new
    end
  end
  
end