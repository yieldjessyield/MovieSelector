Rails.application.routes.draw do
	root 'greetings#hello'
  	get 'greetings/hello'
  	put 'greetings/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
