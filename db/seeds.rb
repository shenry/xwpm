# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account

users = [
  {
    email: "stuart@xwinery.com",
    name: "Stuart Henry",
    password: "xwinery1",
    admin: true
  },
  {
    email: "cmac@xwinery.com",
    name: "Christine Adams",
    password: "xwinery1",
    admin: true
  },
  {
    email: "reed@xwinery.com",
    name: "Reed Renaudin",
    password: "xwinery1",
    admin: true
  },
  {
    email: "barrett@xwinery.com",
    name: "Barrett Marsalek",
    password: "xwinery1",
    admin: false
  },
  {
    email: "erica@xwinery.com",
    name: "Erica O'Brien",
    password: "xwinery1",
    admin: false
  }
]

users.each do |user|
  u = User.new(user)
  u.skip_confirmation!
  u.save!
end

# u = User.new(
#     email: "admin@example.com",
#     password: "1234",
#     admin: true
# )
# u.skip_confirmation!
# u.save!

# Create Customers ("Firms")

# customers = [
#   {
#     :type => "Customer",
#     :name => "Lionstone",
#     :contact_name => "Clare Tooley",
#     :contact_email => "clare.tooley@lionstone.com",
#     :contact_phone => ,
#     :address_line_1 => ,
#     :address_line_2 => ,
#     :city => ,
#     :state => ,
#     :zip => ,
#   }
# ]

# Create Vendors

vendors = [
  {
    
  }
]