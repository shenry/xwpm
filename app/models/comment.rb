# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  author_id   :integer
#  body        :text             default(""), not null
#  actionable  :boolean          default(FALSE), not null
#  resolved    :boolean          default(FALSE), not null
#  resolver_id :integer
#  resolved_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to  :project, inverse_of: :comments, counter_cache: true
  belongs_to  :author, class_name: "User", foreign_key: "author_id"
  belongs_to  :resolver, class_name: "User", foreign_key: "resolver_id"
  
  def published_at(time=nil)
    time ||= self.created_at
    time.strftime("%B %e, %Y %l:%M %p")
  end
end
