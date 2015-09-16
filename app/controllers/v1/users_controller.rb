module V1
  class UsersController < ApplicationController
    skip_before_action :doorkeeper_authorize!, only: [:create]
    prepend_before_action :_swap_current_user_id_for_me, only: [:show]

    def _swap_current_user_id_for_me
      return unless params[:id] == "me"
      return unless current_user

      params[:id] = current_user.id.to_s
    end

  end
end
