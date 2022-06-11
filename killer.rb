program_name = ARGV[0]
tmp_file = "grep_output"

system("ps aux | grep #{program_name} | awk '{print $2, $11}' >> #{tmp_file}")

begin
  File.open(tmp_file) do |file|
    file.each do |line|
      next if /grep|ruby|sh/.match?(line)
      pid = line.match /^\d{1,6}/
      @response = system "kill -9 #{pid}"
    end
  end
  puts @response.nil? ? 
    "Proccess #{program_name} nonexistent." :
    "Proccess #{program_name} killed."
rescue StandardError => e
  raise "Failed in killing #{program_name}."
  raise e
ensure
  system "rm #{tmp_file}"
end
