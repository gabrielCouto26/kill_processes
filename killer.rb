require 'tempfile'

class Killer
  def initialize(processes)
    @processes = processes
  end

  def contract
    @processes.each do |process_name|
      @process_name = process_name
      Tempfile.open do |targets|
        mark targets
        kill targets
      end
      response
    end
  rescue StandardError => e
    raise "Failed in killing #{@process_name}."
    raise e
  end

  private

  def mark(targets)
    system "ps aux |
            grep #{@process_name} |
            awk '{print $2, $11}' >> #{targets.path}"
  end

  def kill(targets)
    targets.each do |process|
      next if /grep|ruby|sh/.match? process
      pid = process.match /^\d{1,6}/
      @response = system "kill -9 #{pid}"
    end
  end

  def response
    if @response.nil?
      puts "Proccess #{@process_name} not found."
    else
      puts "Proccess #{@process_name} killed."
    end
  end
end