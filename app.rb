require_relative 'config/init'
require 'pry' if dev?

require_relative 'lib/gql/schema'
require 'rack/cors'
require 'roda'

class App < Roda
  plugin :default_headers,
         'Content-Type' => 'text/html',
         'Content-Security-Policy' => "default-src 'self'",
         # 'Strict-Transport-Security' =>'max-age=16070400;',
         'X-Frame-Options' => 'deny',
         'X-Content-Type-Options' => 'nosniff',
         'X-XSS-Protection' => '1; mode=block'

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get post options]
    end
  end

  use Rack::Session::Cookie,
      key: '_country_cross',
      secret: '05c9f975b1d9394b6603d9483ee15d43'

  plugin :json

  route do |r|
    r.post 'graphql' do
      params = JSON.parse(r.body.read)

      query = params['query']
      variables = params['variables']

      result = GQL::Schema.execute(query, variables: variables)

      result.to_json
    end
  end
end
