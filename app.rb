# frozen_string_literal: true

require_relative 'compliance'
require 'sinatra/base'

module Compliance
  class Server < Sinatra::Base
    set :server,      :puma
    set :port,        CONFIG.server_port
    set :bind,        CONFIG.server_ip
    set :environment, CONFIG.app_env.to_sym

    before do
      content_type :json
    end

    get '/' do
      'Try /:login'
    end

    get '/:login' do
      user_login = params[:login].strip
      response = Query.new(
        'user.graphql',
        login: user_login, repositories_number: 10
      )
      response.call.to_json
    end

    get '/:login/:repository' do
      user_login = params[:login].strip
      user_repository = params[:repository].strip
      response = Query.new(
        'commits.graphql',
        owner: user_login, name: user_repository, commits_number: 10
      )
      response.call.to_json
    end

    run! if app_file == $PROGRAM_NAME
  end
end
