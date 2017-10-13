require 'rails_helper'
require 'capybara/rspec'
Capybara.default_max_wait_time = 4
Capybara.default_host = "http://127.0.0.1"
RSpec.configure do |config|
config.before do
Capybara.reset_sessions!
end
config.after(:all) do
if Rails.env.test?
FileUtils.rm_rf(Rails.root + "public/test_uploads")
end
end
end
Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }
if defined?(CarrierWave)
CarrierWave::Uploader::Base.descendants.each do |klass|
next if klass.anonymous?
klass.class_eval do
def store_dir
"test_uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
end
def cache_dir
"test_uploads/tmp"
end
end
end
end
