# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag.html_safe
  config.cache_store = :memory_store, { size: 64.megabytes }
end
