# App to demonstrate Rabl functionality in Grape.
# Unfortunately, due to Grape's inner workings, the
# object you return from your method is the only one
# that you will have access to in your view, as @object.
#
# You can, of course, return any object you want, including
# a collection, for use in the view.
#
# The good thing is that this approach is in keeping with
# Grape's minimalistic philosophy.

require 'grape'
require 'tilt'

# rabl has implicit dependencies on active_support.
# active_support/core_ext depends on i18n.
# both of these have to be in the Gemfile.
require 'active_support/core_ext'
require 'rabl'

Rabl.register!

class Gray < Grape::API
  get 'gray' do
    template 'foo.rabl'
    
    # OpenStruct is actually a pretty crappy replacement
    # for a model record. Consequently, this template has limited
    # Rabl functionality--use real models in your app.
    record = OpenStruct.new
    record.message   = "Hello world!"
    record.reply     = "No, goodbye!"
    record.stuff     = {:foo => 'bar', :baz => 'bat'}
    record.not_shown = 'HIDE ME!'
    
    # refer to this as @object in the view.
    records = (1..5).collect { |i| record }
  end
end

# You need to configure env['api.tilt.root'] with a root path
# for your templates. Grape will then honor your #template
# directives in your service description; otherwise, you'll
# get a 500 internal server error asking you to configure tilt.
use Rack::Config do |env|
  env['api.tilt.root'] = File.expand_path('../views', __FILE__).to_s
end
run Gray
