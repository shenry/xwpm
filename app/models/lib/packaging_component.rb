module PackagingComponent

  def self.included(base)
    base.class_eval do
      scope     :active, lambda { where(active: true) }
    end
  end
  
  def active?
    active
  end
end