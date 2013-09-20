ActiveAdmin.register Article do
  form :partial => "form"

  index :as => :blog do |article|
    title :name
    body  :body
  end
end
