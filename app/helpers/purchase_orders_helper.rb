module PurchaseOrdersHelper
  def hash_project_components(projects_array)
    projects_array.inject({}) do |accum, project|
      accum[project.id] = project.materials.map(&:to_s)
      accum
    end
  end
end
