SimpleCov.start 'rails' do
  add_group "Models", "app/models"
  add_group "V1 Controllers", "app/controllers/api/v1"
  add_group "Helpers", "app/helpers"
  add_group "Channels", "app/channels"
end