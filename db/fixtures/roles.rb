["geek", "normal", "visitor"].each do |name|
  Role.seed :name do |role|
    role.name = name
  end
end
