module PurchaseOrdersHelper  
  def hash_project_components(projects, vendor_id)
    projects.inject({}) do |hash, project|
      hash[project.id] = project.components_select_hash_for_vendor(vendor_id)
    end
  end
end
