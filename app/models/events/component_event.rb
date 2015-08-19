class ComponentEvent < ActiveRecord::Base
  
  belongs_to :packageable, polymorphic: true
  belongs_to :actionable, polymorphic: true
  belongs_to :user
  
  validates :packageable_id, :packageable_type, presence: true
  validates :actionable_id, :actionable_type, presence: true, unless: Proc.new { |c| c.class == ComponentEvent::Adjust }
  
  # before_save :adjust_inventory
  # before_destroy :undo_inventory
  
  class Receive < ComponentEvent; end
  class Adjust < ComponentEvent; end
  class Discontinue < ComponentEvent 
    def inventory_action(options={})
      # Do Nothing
    end
  end
  class Deplete < ComponentEvent
    def inventory_action(options={})
      undo = options[:undo] || false
      action = undo ? :+ : :-
      packageable.quantity = packageable.quantity.send(action, delta)
      packageable.save
    end
  end
  
  def inventory_action(options={})
    undo    = options[:undo] || false
    action  = undo ? :- : :+
    packageable.quantity = packageable.quantity.send(action, delta)
    packageable.save
  end
end