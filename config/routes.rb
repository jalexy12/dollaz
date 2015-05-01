Rails.application.routes.draw do
  root 'money#index'

  get '/get_paid' => 'money#get_paid'
  get '/collect/:result' => 'money#collect', as: 'co'
end
