module PackagingComponent
  def self.included(base)
    base.class_eval do
      validates :item_number, uniqueness: true
      
      scope :active, lambda { joins(:vendor).where(active: true) }
      
      mount_uploader :image, ImageUploader
      
      before_save :upcase_item_number
      
      paginates_per 10
      
      def units_options
        [['mm', 'mm'], ['in', 'in']]
      end
      
      def self.select_options(array)
        array.map { |a| [a.to_s, a.id] }
      end
      
    end
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
  
  def active?
    active
  end
  
  def units_options
    [['mm', 'mm'], ['in', 'in']]
  end
  
  private
  
  def image_regexp
    /.*\/(\w*)\/(\w*)\.\w{3,4}/
  end
  
  def upcase_item_number
    item_number.upcase!
  end
end