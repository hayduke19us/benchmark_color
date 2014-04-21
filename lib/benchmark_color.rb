require "colorize"

module Abacus

  def self.block_time
    measure {yield}
  end

  def self.measure
    #to add Process::Tms object in future
    start_process, before = Process.times, Time.now
    yield
    end_process, after = Process.times, Time.now
    ((after - before) * 1000) 
  end
end

module Report
  $stdout.sync = true

  def self.output block_hash, winner, loser, option
    unless block_hash.count == 1
      block_array = block_hash.sort_by {|k, v| v}
      first = block_array.shift
      last = block_array.pop
      Report.format first, last, block_array, winner, loser, option
    else
      block_hash = block_hash.flatten.join(' ')
      Report.seperator
      puts 
      puts "#{Report.arrow}" "#{block_hash.colorize(color: winner)}"
      puts
      Report.seperator
    end

  end

  def self.format first, last, block_array, winner, loser, option
    puts Report.seperator
    puts "#{Report.arrow}" "#{ first.join(' ').colorize(color: winner)}"
    block_array.each do |block|
      puts "#{Report.small_arrow}" "#{block.join(' ').colorize(color: option)}"
    end
    puts "#{Report.arrow}" "#{ last.join(' ').colorize(color: loser)}"
    puts
    puts Report.seperator
  end

  def self.arrow
    " -----------------------> ".colorize(color: :light_blue)
  end

  def self.small_arrow
    " ----> ".colorize(color: :light_blue)
  end

  def self.seperator
   puts "=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
  end

end

class Benchmark

  attr_reader :block_hash
  attr_accessor :winner, :loser, :option

  include Abacus
  include Report

  def initialize args={}
    @winner = args.fetch(:winner, :green)
    @loser = args.fetch(:loser, :red)
    @option = args.fetch(:option, :light_blue)
    @block_hash ||= {}
  end

  def measure label = ""
    if block_given?
      block = Abacus.block_time {yield}
      @block_hash[label] = block
      true
    else
      puts instructions
      false
    end
  end

  def compare
    Report.output @block_hash, winner, loser, option
  end

  def instructions
    %{You must supply a block of code like this:

     b = Benchmark.new
     b.measure("some-label:") { n.times do; x = 1 + 3; end}
     b.compare #to get your results

     Or this:

     n = 1000
     b = Benchmark.new
     b.measure("some-label:") do
       n.times do 
         x = 1 + 3
       end
     end
     b.compare #to get your results}
  end

end

