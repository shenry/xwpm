module PackagingComponent

  def self.included(base)
    base.class_eval do
      scope :active, lambda { where(active: true) }
      
      mount_uploader :image, ImageUploader
    end
  end
  
  def active?
    active
  end
  
  def units_options
    [['mm', 'mm'], ['in', 'in']]
  end
end