opts = {
  :amqp => 'amqp://guest:guest@localhost:5672/',
  :vhost => '/',
  :exchange => 'sneakers',
  :exchange_type => :direct,
  :timeout_job_after => 3600,
  :heartbeat => 1,
  :workers => 1,               # Number of per-cpu processes to run
  :threads => 1,
  :durable => true,
  :log => 'log/sneakers.log',     # Log file
  :pid_path => 'log/pids/sneakers.pid',
}

Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO
