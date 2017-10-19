require_relative 'config/init'

require 'roda'

class App < Roda
  plugin :default_headers,
         'Content-Type' => 'text/html',
         'Content-Security-Policy' => "default-src 'self'",
         # 'Strict-Transport-Security' =>'max-age=16070400;',
         'X-Frame-Options' => 'deny',
         'X-Content-Type-Options' => 'nosniff',
         'X-XSS-Protection' => '1; mode=block'

  use Rack::Session::Cookie,
      key: '_country_cross',
      secret: '05c9f975b1d9394b6603d9483ee15d43'

  route do |r|
    r.multi_route

    r.root do
      view 'index'
    end
  end
end
