# == Schema Information
#
# Table name: packages
#
#  id             :integer          not null, primary key
#  name           :string           default(""), not null
#  description    :string           default(""), not null
#  closure_id     :integer
#  bottle_id      :integer
#  front_label_id :integer
#  back_label_id  :integer
#  capsule_id     :integer
#  shipper_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Package < ActiveRecord::Base
  has_many    :projects
  belongs_to  :closure

  belongs_to  :front_label, class_name: "Label", foreign_key: "front_label_id"
  belongs_to  :back_label,  class_name: "Label", foreign_key: "back_label_id"
  
  belongs_to  :capsule
  belongs_to  :bottle
  belongs_to  :shipper
end
