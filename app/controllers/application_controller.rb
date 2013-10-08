class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :render_metabar

  def render_metabar
    "<header>
      <div class='logo'>Writrr</div>
      <nav>
        <a href='#'>Test</a>
        <a href='#'>Test</a>
        <a href='#'>Test</a>
      </nav>
    </header>".html_safe
  end
end
