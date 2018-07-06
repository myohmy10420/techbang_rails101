listen "/home/app/techbang_rails101/shared/tmp/unicorn.sock"
worker_processes 2
pid "/home/app/techbang_rails101/shared/tmp/pids/unicorn.pid"
stderr_path "/home/app/techbang_rails101/shared/log/unicorn.log"
stdout_path "/home/app/techbang_rails101/shared/log/unicorn.log"

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
