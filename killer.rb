require 'tempfile'

program_name = ARGV[0]

begin
  Tempfile.open do |file|
    system "ps aux | grep #{program_name} | awk '{print $2, $11}' >> #{file.path}"
    file.each do |line|
      next if /grep|ruby|sh/.match?(line)
      pid = line.match /^\d{1,6}/
      @response = system "kill -9 #{pid}"
    end
    puts @response.nil? ? 
      "Proccess #{program_name} is not running." :
      "Proccess #{program_name} killed."
  end
rescue StandardError => e
  raise "Failed in killing #{program_name}."
  raise e
end