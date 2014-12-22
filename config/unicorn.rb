worker_processes Integer(ENV['UNICORN_WORKERS'] || 2)
timeout Integer(ENV['UNICORN_TIMEOUT'] || 35)
working_directory "/app"
preload_app true

# Based on http://help.cloud66.com/web-server/unicorn-rack-server.html
listen "/tmp/web_server.sock", :backlog => Integer(ENV['UNICORN_BACKLOG'] || 64)
pid '/tmp/web_server.pid'
stderr_path "/log/unicorn.stderr.log"
stdout_path "/log/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  old_pid = '/tmp/web_server.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
