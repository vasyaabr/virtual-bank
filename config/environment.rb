# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rottenpotatoes::Application.initialize!

# Additional logger
class AuditLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n" 
  end 
end

logfile = File.open('log/audit.log', 'a')    
logfile.sync = true
audit_log = AuditLogger.new(logfile)
