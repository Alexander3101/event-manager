class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # если вошёл или вышел, остаться на этой же странице
  def after_sign_in_path_for(resource_or_scope)
    request.referrer
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
