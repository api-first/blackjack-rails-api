module V1
  class UsersController < ApplicationController
    skip_before_action :doorkeeper_authorize!, only: [:create]
  end
end
