# == Schema Information
#
# Table name: component_events
#
#  id               :integer          not null, primary key
#  packageable_id   :integer
#  packageable_type :string
#  actionable_id    :integer
#  actionable_type  :string
#  delta            :float
#  user_id          :integer
#  type             :string
#

class ComponentEvent < ActiveRecord::Base
  
  belongs_to :packageable, polymorphic: true
  belongs_to :actionable, polymorphic: true
  belongs_to :user
  
  validates :packageable_id, :packageable_type, presence: true
  validates :actionable_id, :actionable_type, presence: true, 
            unless: Proc.new { |c| [ComponentEvent::Adjust, ComponentEvent::Deactivate, ComponentEvent::Reactivate].include? c.class }

  
  class Receive < ComponentEvent; end
  class Adjust < ComponentEvent; end
  class Reactivate < ComponentEvent
    def inventory_action(options={})
      # Do Nothing
    end
  end
  class Deactivate < ComponentEvent 
    def inventory_action(options={})
      # Do Nothing
    end
  end
  class Deplete < ComponentEvent
    def inventory_action(options={})
      undo = options[:undo] || false
      action = undo ? :+ : :-
      packageable.quantity = packageable.quantity.send(action, delta).to_i
      packageable.save
    end
  end
  
  # Default inventory_action
  def inventory_action(options={})
    undo    = options[:undo] || false
    action  = undo ? :- : :+
    packageable.quantity = packageable.quantity.send(action, delta).to_i
    packageable.save!
  end
end
