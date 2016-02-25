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

  def clear_sp(conn)
    sps = get_sps(conn)
    sps.each do |sp|
      conn.execute("drop procedure #{sp}")
    end
  end

  def get_sps(conn)
    res = conn.exec_query("select ROUTINE_NAME from information_schema.routines where routine_type = 'PROCEDURE'")
    sps = []
    res.each do |result|
      sps << result['ROUTINE_NAME']
    end
    return sps
  end

  desc "download store procedure"
  task dl_sp: :environment do
    conn = ActiveRecord::Base.connection
    db_name = conn.current_database
    folder = "tsql/#{db_name}"
    FileUtils.mkdir_p folder

    res = conn.exec_query("select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.routines where routine_type = 'PROCEDURE'")
    res.each do |result|
      filename = "#{folder}/#{result['ROUTINE_NAME']}.sql"
      File.open(filename, 'w') { |file| file.write(result['ROUTINE_DEFINITION']) }
    end
  end

  desc "clear store procedure"
  task clear_sp: :environment do
    conn = ActiveRecord::Base.connection
    clear_sp(conn)
  end

  desc "upload store procedure"
  task ul_sp: :environment do
    conn = ActiveRecord::Base.connection
    sps = get_sps(conn)

    db_name = conn.current_database
    folder = "tsql/#{Rails.env}"

    Dir["#{folder}/*.sql"].each do |file|
      puts file
      sql = File.read(file)
      if file =~ /([^\/]*)\.sql/ then
        sp_name = $1
        if sps.include?(sp_name) then
          sql.gsub!(/create PROCEDURE \[dbo\]\.\[#{sp_name}\]/mi, "alter PROCEDURE [dbo].[#{sp_name}]")
        end
        #puts sql
        conn.execute("SET ANSI_NULLS ON")
        conn.execute("SET QUOTED_IDENTIFIER ON")
        conn.execute(sql)
      end
    end
  end

end
