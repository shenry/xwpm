module PackagingComponent
  def self.included(base)
    base.class_eval do
      scope :active, lambda { where(active: true) }
      mount_uploader :image, ImageUploader
      
      def units_options
        [['mm', 'mm'], ['in', 'in']]
      end
    end
  end
  
  def width_placeholder
    "D"
  end
  
  def diameter
    width
  end
  
  def active?
    active
  end
  
  def units_options
    [['mm', 'mm'], ['in', 'in']]
  end
end