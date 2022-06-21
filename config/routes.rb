Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "app#ussd_simulator"
  post "/ussd", to: "app#ussd_controller"
end
