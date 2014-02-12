class WeightsController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.weights
  end
end
