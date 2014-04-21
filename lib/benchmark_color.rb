require "colorize"

module Abacus

  def self.block_time
    measure {yield}
  end

  def self.measure 
    start_process, before = Process.times, Time.now
    yield
    end_process, after = Process.times, Time.now
    ((after - before) * 1000) 
  end
end

module Report
  $stdout.sync = true

  def self.output block_hash, winner, loser
    unless block_hash.count == 1
      block_array = block_hash.sort_by {|k, v| v}
      first = block_array.shift
      last = block_array.pop
      Report.format first, last, block_array, winner, loser
    else
      block_hash = block_hash.flatten.join(' ')
      Report.seperator
      puts 
      puts "#{Report.arrow}" "#{block_hash.colorize(color: winner)}"
      puts
      Report.seperator
    end

  end

  def self.format first, last, block_array, winner, loser
    puts Report.seperator
    puts "#{Report.arrow}" "#{ first.join(' ').colorize(color: winner)}"
    block_array.each do |block|
      puts "#{Report.small_arrow}" "#{block.join(' ').colorize(color: :light_blue)}"
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

  include Abacus
  include Report

  def initialize args={}
    @winner = args.fetch(:winner, :green)
    @loser = args.fetch(:loser, :red)
    @block_hash ||= {}
  end

  def measure label = ""
    label1 = label
    block1 = Abacus.block_time {yield}
    @block_hash[label] = block1
  end

  def compare 
    unless @block_hash.empty?
      Report.output @block_hash, @winner, @loser
    else
      puts "You haven't measured anything yet"
    end
  end

end

