require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  BRAND_NAME = 'IsFree'.freeze
  respond_to :html

  protect_from_forgery with: :exception
  def meta_title(title)
    [title, BRAND_NAME].reject(&:empty?).join(' | ')
  end
end
