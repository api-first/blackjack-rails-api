class ApplicationController < JSONAPI::ResourceController
  include PolicyAuthorization
  
  after_action :_skip_session

  protect_from_forgery with: :null_session

  before_action :doorkeeper_authorize!

  # Context for the JSONAPI::ResourceController methods
  def context
    {
      controller: self,
      current_user: current_user
    }
  end

  def current_user
    @current_user ||= _doorkeeper_user
  end

  def model_class
    controller_name.classify.constantize
  end

  def _skip_session
    request.session_options[:skip] = true
  end

  def _doorkeeper_user
    return unless doorkeeper_token

    User.find(doorkeeper_token.resource_owner_id)
  end
end
