class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Response
  include Error::ErrorHandler
  include ActionController::MimeResponds

  def fallback_index_html
    respond_to do |format|
      format.html { render body: Rails.root.join('public/index.html').read }
    end
    # render :file => 'public/index.html', :layout => false
  end
end
