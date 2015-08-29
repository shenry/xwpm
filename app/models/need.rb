# == Schema Information
#
# Table name: needs
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  appellation :string
#  variety     :string
#  vintage     :string
#  budget      :string
#  notes       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Need < ActiveRecord::Base
  belongs_to  :customer
  has_many    :wine_shipments
  has_one     :project
end
