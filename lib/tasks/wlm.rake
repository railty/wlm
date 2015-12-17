namespace :wlm do
  PID_FILE = 'tmp/office.pid'

	desc "start libre office as daemon"
  task start_office: :environment do
    Rails.logger       = Logger.new(Rails.root.join('log', 'office.log'))
    Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

    if not File.exist?(PID_FILE) then
      Process.daemon(true, true)

      File.open(PID_FILE, 'w') { |f| f << Process.pid }

      Signal.trap('TERM') { abort }
      Signal.trap('SIGINT') { abort }

      Rails.logger.info "Start daemon..."

      loop do
        Rails.logger.info "working ..."
        `soffice --accept="socket,host=localhost,port=2002;urp;" --norestore --nologo --nodefault --headless`
        sleep ENV['INTERVAL'] || 1
      end
    end
  end

  desc "stop libre office daemon"
  task stop_office: :environment do
    Rails.logger       = Logger.new(Rails.root.join('log', 'office.log'))
    Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

    if File.exist?(PID_FILE) then
      begin
        #kill the soffice
        `kill \`ps -A | grep soffice.bin | awk '{print $1}'\``
        #kill daemon
        Process.kill('SIGINT', File.read(PID_FILE).to_i)
      rescue => e
        Rails.logger.info e
      end
      File.delete(PID_FILE)
    end

    Rails.logger.info "kill daemon..."
  end
end
