# == Schema Information
#
# Table name: packaging_component_orders
#
#  id                       :integer          not null, primary key
#  component_requirement_id :integer
#  purchase_order_id        :integer
#  quantity                 :float            default(0.0)
#  price                    :float            default(0.0)
#  received                 :boolean          default(FALSE), not null
#

class PackagingComponentOrder < ActiveRecord::Base
  include AASM
  
  belongs_to  :purchase_order, inverse_of: :line_items, counter_cache: :line_items_count
  belongs_to  :packageable, polymorphic: true
  # belongs_to  :component_requirement, inverse_of: :packaging_component_order
  has_one     :project, through: :component_requirement
  has_many    :events, class_name: "ComponentEvent", as: :actionable
  
  validates :packageable_id, :packageable_type, :purchase_order_id, :quantity, :price, presence: true
  
  aasm do
    state :open, initial: true
    state :received
    
    event :receive do
      transitions from: :open, to: :received
      after do |options|
        create_inventory_event!(options)
      end
    end
    
    event :undo do
      transitions from: :received, to: :open
      after do
        destroy_inventory_event!
      end
    end
  end
  
  def state
    aasm_state
  end
  
  def event_action
    "Purchase"
  end
  
  def total_cost
    price + allocated_overhead
  end
  
  def allocated_overhead
    component_share = price / purchase_order.subtotal
    component_share * purchase_order.overhead
  end
  
  private

  def create_inventory_event!(options={})
    options = options.merge(actionable: self, delta: self.quantity)
    event = ComponentEvent::Receive.new(options)
    packageable.events << event
  end
  
  def destroy_inventory_event!(options={})
    event = ComponentEvent::Receive.find_by(actionable_id: self.id, actionable_type: self.class.to_s)
    puts "destroying......................"
    puts "event is #{event.inspect}"
    packageable = event.packageable
    packageable.events.destroy(event)
  end
end
