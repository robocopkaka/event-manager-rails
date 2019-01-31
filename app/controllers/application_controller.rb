class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Response
  include Error::ErrorHandler

  def fallback_index_html
    render :file => 'public/index.html', :layout => false
    puts "stuff was rendered"
  end
end
