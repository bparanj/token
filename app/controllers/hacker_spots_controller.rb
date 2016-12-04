class HackerSpotsController < ApiController
  before_action :require_login!
  
  def index
    # This is protected by API token
    render json: { spots: 'List of places to work in coffee shops'}
  end
end

