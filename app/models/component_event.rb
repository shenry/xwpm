class ComponentEvent < ActiveRecord::Base
  attr_accessor :delta
  
  belongs_to :packageable, polymorphic: true
  belongs_to :actionable, polymorphic: true
  
  validates :packageable_id, :packageable_type, :actionable_id, :actionable_type, presence: true
  
  before_save :adjust_inventory
  before_destroy :adjust_inventory
  
  class Purchase < ComponentEvent; end
  class Receive < ComponentEvent; end
  class Deplete < ComponentEvent; end
  class Adjust < ComponentEvent; end
  class Discontinue < ComponentEvent; end
  
  private
  
  def adjust_inventory
    puts "called adjust_inventory"
    # packageable.quantity = packageable.events.inject(0) { |sum, event| sum += event.delta }
    # packageable.save
  end
end