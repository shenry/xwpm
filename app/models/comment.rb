class Comment < ActiveRecord::Base
  belongs_to  :project, counter_cache: true
  belongs_to  :author, class_name: "User", foreign_key: "author_id"
  belongs_to  :resolver, class_name: "User", foreign_key: "resolver_id"
  
  def published_at(time=nil)
    time ||= self.created_at
    time.strftime("%B %e, %Y %l:%M %p")
  end
end
