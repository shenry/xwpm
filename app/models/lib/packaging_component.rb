module PackagingComponent
  
  def self.included(base)
    base.class_eval do
      has_many :events, class_name: "ComponentEvent", as: :packageable, dependent: :destroy, 
                after_add: :update_inventory, after_remove: :undo_inventory
      has_many :line_items, as: :packageable, dependent: :destroy, class_name: "PackagingComponentOrder"
      has_many :purchase_orders, through: :line_items
      
      validates :item_number, uniqueness: true
      validates_numericality_of :quantity, only_integer: true, greater_than_or_equal_to: 0,
                                message: "must be positive"
      
      scope :active, lambda { joins(:vendor).where(aasm_state: "Active") }
      scope :inactive, -> { joins(:vendor).where(aasm_state: "Inactive") }
      
      mount_uploader :image, ImageUploader
      
      before_save :upcase_item_number, :set_state
      
      paginates_per 10
      
      def units_options
        [['mm', 'mm'], ['in', 'in']]
      end
      
      def self.select_options(array)
        array.map { |a| [a.to_s, a.id] }
      end
    end
  end
  
  def states
    ComponentState.states
  end
  
  def state
    aasm_state
  end
  
  def has_pending_inventory?
    pending_inventory > 0
  end
  
  def pending_inventory
    line_items.where(aasm_state: "open").sum(:quantity)
  end
  
  def usable_inventory
    pending_inventory + quantity
  end
  
  def fudge_factor(qty)
    0
  end
  
  def image_id
    image.to_s.match(image_regexp)[2]
  end
  
  def image_version
    image.to_s.match(image_regexp)[1]
  end
  
  def to_s
    "#{vendor.name} - #{item_number}"
  end
  
  def width_placeholder
    "D"
  end
  
  def diameter
    width
  end
  
  def units_options
    [['mm', 'mm'], ['in', 'in']]
  end
  
  private
  
  def set_state
    puts "called set_state!"
    self.aasm_state = events.inject(ComponentState::Active.new) do |last, this|
      last.transition(this)
    end.to_s
  end
  
  def update_inventory(obj)
    puts "................... UPDATING INVENTORY ......................."
    begin 
      obj.inventory_action
      self.save
    end
  end
  
  def undo_inventory(obj)
    puts ".................... UNDOING INVENTORY ......................."
    begin
      obj.inventory_action(undo: true)
      self.save
    end
  end
  
  def image_regexp
    /.*\/(\w*)\/(\w*)\.\w{3,4}/
  end
  
  def upcase_item_number
    item_number.upcase!
  end
end