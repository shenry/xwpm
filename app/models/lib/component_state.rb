class ComponentState
  def transition(event)
    Invalid.new
  end
  
  class Incomplete < ComponentState
    def transition(event)
      case event
      when ComponentEvent::Adjust; Spawned.new
      else; Invalid.new
      end
    end
  end
  
  class Adjusted < ComponentState
    def transition(event)
      inventory_transition(event)
    end
  end
  
  class Received < ComponentState
    def transition(event)
      inventory_transition(event)
    end
  end
  
  class Depleted < ComponentState
    def transition(event)
      inventory_transition(event)
    end
  end
  
  class Spawned < ComponentState
    def transition(event)
      inventory_transition(event)
    end
  end
  
  class Discontinued < ComponentState; end
  class Invalid < ComponentState; end
  
  private
  
  def inventory_transition(event)
    case event
    when ComponentEvent::Receive; Received.new
    when ComponentEvent::Deplete; Depleted.new
    when ComponentEvent::Adjust; Adjusted.new
    when ComponentEvent::Discontinue; Discontinued.new
    else; Invalid.new
    end
  end
  
end