require 'tempfile'

class Killer
  def initialize(proccess_name)
    @proccess_name = proccess_name
  end

  def kill
    Tempfile.open do |file|
      system "ps aux | grep #{@proccess_name} | awk '{print $2, $11}' >> #{file.path}"
      file.each do |line|
        next if /grep|ruby|sh/.match? line
        pid = line.match /^\d{1,6}/
        @response = system "kill -9 #{pid}"
      end
      response
    end
  rescue StandardError => e
    raise "Failed in killing #{@proccess_name}."
    raise e
  end

  private

  def response
    if @response.nil?
      puts "Proccess #{@proccess_name} is not running."
    else
      puts "Proccess #{@proccess_name} killed."
    end
  end
end