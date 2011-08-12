require "tiny_timer/version"

module TinyTimer

  class Timer
    @@timers = []

    class << self
      def run_timer(desc=nil, &block)
        # desc ||= Rake.application.last_description
        new_timer = self.new
        @@timers.push(new_timer)
        puts "*** Started: #{desc}" #TODO: ANSI color for Started
        yield
        puts "*** Finished. Total running time: #{Time.now - new_timer.start_time} seconds"
        @@timers.pop
      end

      def count
        @@timers.size
      end

      def current_timer
        @@timers.last
      end
    end

    attr_reader :start_time

    def initialize
      @start_time = Time.now
    end

    def step(desc='')
      puts "------ start #{desc} ..."
      start = Time.now
      yield
      puts "------ finish #{desc} in #{Time.now - start} seconds"
    end
  end

end

  # User Interface (global convenience methods)
  def timer(desc=nil, &block)
    TinyTimer::Timer.run_timer(desc, &block)
  end

  def step(desc='', &block)
    timer = TinyTimer::Timer.current_timer
    # TODO: raise exeption if timer is nil
    timer.step(desc,&block) if timer
  end

