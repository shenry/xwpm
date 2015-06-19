class Label < PackagingComponent
  belongs_to  :vendor
  has_many    :front_labeled_projects,  class_name: "Project", foreign_key: "front_label_id"
  has_many    :back_labeled_projects,   class_name: "Project", foreign_key: "back_label_id"
end