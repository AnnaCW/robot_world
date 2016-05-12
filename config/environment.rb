require 'bundler'
Bundler.require

APP_ROOT = File.expand_path("..", __dir__)

#require the controller(s)
Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '*.rb')).each {|file| require file}

#require the models(s)
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each {|file| require file}

#no longer need to require our files still need to require YAML store

class RobotWorldApp < Sinatra::Base
  set :root, APP_ROOT
  set :method_override, true
  set :views, File.join(APP_ROOT, 'app', 'views')
  #built in sinarta method that looks for these files.tells sinatra where our views are
  set :public_folder, File.join(APP_ROOT, 'app', 'public')
end
