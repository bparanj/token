Rails.application.routes.draw do
  get 'hacker_spots/index'

  scope :format => true, :constraints => { :format => 'json' } do
    post   "/sign-in"       => "sessions#create"
    delete "/sign-out"      => "sessions#destroy"
  end
end
