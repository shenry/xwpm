class ProjectEvent < ActiveRecord::Base
  belongs_to :project, inverse_of: :events
  belongs_to :user, inverse_of: :project_events
  
  default_scope { order("created_at ASC") }
  
  before_create :authorize_state_change
  
  validates :state, inclusion: { in: Project::STATES }
  
  def init(params=nil)
    state = params[:state] || Project::STATES[0]
    super
  end
  
  def self.with_last_state(state)
    group("project_id").having(state: state)
  end
  
  private
  
  def authorize_state_change
    
  end
end
