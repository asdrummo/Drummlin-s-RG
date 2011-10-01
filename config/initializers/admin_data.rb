AdminData.config do |config|
  config.is_allowed_to_view = lambda {|controller| controller.send('confirm_logged_in?') }
  config.is_allowed_to_update = lambda {|controller| controller.send('confirm_logged_in') }
end