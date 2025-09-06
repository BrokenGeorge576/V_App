class ApplicationController < ActionController::Base
  before_action :set_global_filter_data
  allow_browser versions: :modern

  private 
  
  def set_global_filter_data
    @file_types = ManagedFile.pluck(:file_type).uniq.sort
    @themes = Theme.order(:name)
  end
end
