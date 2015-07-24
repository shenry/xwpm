class FixIndexes < ActiveRecord::Migration
  def change
    execute "SELECT setval('projects_id_seq', 1000)"
    execute "SELECT setval('friendly_id_slugs_id_seq', 1000)"
    execute "SELECT setval('users_id_seq', 1000)"
    execute "SELECT setval('firms_id_seq', 1000)"
    execute "SELECT setval('attachments_id_seq', 1000)"
    execute "SELECT setval('comments_id_seq', 1000)"
    execute "SELECT setval('components_id_seq', 1000)"
    execute "SELECT setval('wines_id_seq', 1000)"
    execute "SELECT setval('wine_shipments_id_seq', 1000)"
    execute "SELECT setval('component_requirements_id_seq', 1000)"
    execute "SELECT setval('vendor_products_id_seq', 1000)"
    execute "SELECT setval('bottles_id_seq', 1000)"
    execute "SELECT setval('capsules_id_seq', 1000)"
    execute "SELECT setval('closures_id_seq', 1000)"
    execute "SELECT setval('front_labels_id_seq', 1000)"
    execute "SELECT setval('back_labels_id_seq', 1000)"
    execute "SELECT setval('purchase_orders_id_seq', 1000)"
    execute "SELECT setval('packaging_component_orders_id_seq', 1000)"
  end
end
