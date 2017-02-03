class WelcomeController < ApplicationController
  def index
    p "test"
    current_user
    # byebug
  end
end
