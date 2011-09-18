require 'bundler/setup'
Bundler.require

assets = Sprockets::Environment.new('.') do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path('assets/javascripts')
assets.append_path('vendor/javascripts')
assets.append_path('assets/stylesheets')
assets.append_path('vendor/stylesheets')
assets.append_path('assets/images')
assets.append_path('vendor/images')

module AssetHelpers
  def asset_path(name)
    "/assets/#{name}"
  end
end

assets.context_class.instance_eval do
  include AssetHelpers
end

get '/assets/*' do
  new_env = env.clone
  new_env["PATH_INFO"].gsub!("/assets", "")
  assets.call(new_env)
end

get '/' do
  haml :index
end
