Rails.application.routes.draw do
  resources :people, :messages, :bills, :payments
  resources :sessions, only: [:new, :create, :destroy]

  root "pages#home"
  get "/admin", to: "pages#admin"
  get "/login",  to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  
  delete "/payments/:id/accept", to: "payments#accept", as: "accept_payment"
  delete "/payments/:id/reject", to: "payments#reject", as: "reject_payment"
end
