class HomeController < ApplicationController
  def index
    render json: {message: 'Olá mundo'}
  end
end
