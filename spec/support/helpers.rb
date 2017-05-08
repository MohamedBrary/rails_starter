require_relative 'helpers/session_helpers'
require_relative 'helpers/controller_helpers'


RSpec.configure do |config|
  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, :type => type
    config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
    config.include ::Rails::Controller::Testing::Integration, :type => type
  end
  config.include ControllerHelpers, type: :controller  
  config.include Features::SessionHelpers, type: :feature
end
