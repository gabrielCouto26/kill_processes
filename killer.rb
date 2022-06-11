require 'tempfile'

class Killer
  @program_name = ARGV[0]

  def self.kill
    Tempfile.open do |file|
      system "ps aux | grep #{@program_name} | awk '{print $2, $11}' >> #{file.path}"
      file.each do |line|
        next if /grep|ruby|sh/.match?(line)
        pid = line.match /^\d{1,6}/
        @response = system "kill -9 #{pid}"
      end
      response
    end
  rescue StandardError => e
    raise "Failed in killing #{@program_name}."
    raise e
  end

  private

  def self.response
    if @response.nil?
      puts "Proccess #{@program_name} is not running."
    else
      puts "Proccess #{@program_name} killed."
    end
  end
end

Killer.kill