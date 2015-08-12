class Winery < Firm
  has_many :bottled_at_projects, class_name: "Project", foreign_key: "bottled_at_id"
  has_many :bottler_projects, class_name: "Project", foreign_key: "bottler_id"
  
  
  class << self
    def primary_association
      :bottled_at_projects
    end
    
    def select_options
      all.order(:name).map { |w| [w.id, w.to_s] }
    end
    
    def bip_select_options_for(string)
      ["", "Select a #{string}"] + select_options
    end
  end
  
  def to_s
    name
  end
  
  validates :bond, presence: true
end