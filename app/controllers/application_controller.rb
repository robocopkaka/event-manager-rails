class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Response
  include Error::ErrorHandler
  include ActionController::MimeResponds

  around_action :set_user

  def fallback_index_html
    respond_to do |format|
      format.html { render body: Rails.root.join('public/index.html').read }
    end
    # render :file => 'public/index.html', :layout => false
  end

  def set_user
    CurrentUser.user = current_user
    yield
  ensure
    CurrentUser.user = nil
    # to address the thread variable leak issues in Puma/Thin webserver (from StackOverflow)
    # https://stackoverflow.com/questions/2513383/access-current-user-in-model
  end
end
