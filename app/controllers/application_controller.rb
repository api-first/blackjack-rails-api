class ApplicationController < JSONAPI::ResourceController
  after_action :_skip_session

  protect_from_forgery with: :null_session

  # Context for the JSONAPI::ResourceController methods
  def context
    {
      controller: self,
    }
  end

  def model_class
    controller_name.classify.constantize
  end

  def _skip_session
    request.session_options[:skip] = true
  end
end
