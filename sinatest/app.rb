require "sinatra"
require "timeout"
require "statsd"


class CantConnectError < StandardError; end

configure do
  host = ENV['STATSD_HOST'] || 'localhost'
  port = ENV['STATSD_PORT'] || 8125
  set :statsd, Statsd.new(host, port)
end

get "/" do
  statsd = settings.statsd
  begin
    statsd.time('execution.time') do
      action = rand
      min, max = [50,300] 
      min, max = [1000,2000] if action > 0.45
      min, max = [6000,7000] if action > 0.75
      raise CantConnectError if action > 0.90
      waiting = rand(min..max)

      foobar = rand(10)

      Timeout::timeout(2) do
        logger.info "wait = #{waiting}"
        sleep(waiting/1000.0)
      end 
      statsd.gauge("foobar.value", "+#{foobar}")
    end

  rescue CantConnectError
    logger.info "Cant connect error"
    statsd.increment "error.connect"
    halt 502, "Bad upstream"

  rescue Timeout::Error
    logger.info "Timeout error"
    statsd.increment "error.timeout"
    halt 503, "Upstream timeout"
  end
  status 200
end



