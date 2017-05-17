require "sinatra"
require "timeout"

class CantConnectError < StandardError; end

configure do
  set :bind, '0.0.0.0'
end

get "/" do
  begin
    action = rand
    min, max = [50,300] 
    min, max = [1000,2000] if action > 0.95
    min, max = [6000,7000] if action > 0.99
    raise CantConnectError if action > 0.998
    waiting = rand(min..max)

    foobar = rand(10)

    Timeout::timeout(2) do
      logger.info "wait = #{waiting}"
      sleep(waiting/1000.0)
    end 

  rescue CantConnectError
    logger.info "Cant connect error"
    halt 502, "Bad upstream"

  rescue Timeout::Error
    logger.info "Timeout error"
    halt 503, "Upstream timeout"
  end
  status 200
end

