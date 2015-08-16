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
  belongs_to  :component_requirement, inverse_of: :packaging_component_order
  has_one     :project, through: :component_requirement
  has_one     :purchase_event, class_name: "Purchase", as: :actionable
  has_one     :receive_event, class_name: "Receive", as: :actionable
  
  validates_uniqueness_of :component_requirement_id
  
  aasm do
    state :ordered, initial: true, before_enter: :process_purchase!
    state :received
    
    event :receive do
      success do
        process_receipt!
      end
      transitions from: :ordered, to: :received
    end
    
    event :cancel_receive do
      success do 
        undo_receipt!
      end
      transitions from: :received, to: :ordered
    end
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
  
  def packageable
    self.component_requirement.packageable
  end
  
  private
  
  def process_purchase!
    puts "!!!!!!!!!!!!! PURCHASING !!!!!!!!!!!!!!!!!!!!!!!!!"
  end
  
  def process_receipt!
    puts "............... self is #{self.inspect}"
    # packageable.events << self.event.new(delta: self.quantity)
  end
  
  def undo_receipt!
    puts "-------------------- self is #{self.inspect}"
    puts "-------------------- event is #{self.event.inspect}"
    self.event.destroy
  end
end
