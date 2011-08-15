require "tiny_timer/version"

module TinyTimer
  TIMER_CHARS = '*** '
  LEADING_CHARS = TIMER_CHARS
  STEP_CHARS = TIMER_CHARS + '  '

  class Timer
    @@timers = []
    @@leading = ''

    class << self
      def run_timer(desc=nil, &block)
        # desc ||= Rake.application.last_description
        new_timer = self.new
        @@timers.push(new_timer)
        @@leading += LEADING_CHARS if self.count > 1 # 4 whitespaces
        puts "#{@@leading}#{TIMER_CHARS}Started: #{desc}" #TODO: ANSI color for Started
        yield
        puts "#{@@leading}#{TIMER_CHARS}Finished. Total running time: #{Time.now - new_timer.start_time} seconds"
        @@leading.sub!(/.{#{LEADING_CHARS.size}}$/,'') if self.count > 1
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
      @step_count = 0
    end

    def step(desc='')
      if block_given?
        @step_count += 1
        puts "#{@@leading}#{STEP_CHARS}#{@step_count}. #{desc} ... "
        start = Time.now
        yield
        puts "#{@@leading}#{STEP_CHARS}-- finished in #{Time.now - start} seconds"
      end
    end
    
    # use this method if you only want to print out something, do not create an empty step or timer
    def comment(desc='')
      puts "#{@@leading}#{STEP_CHARS}#{desc}" if desc.length > 0
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
  
  def comment(desc='')
    timer = TinyTimer::Timer.current_timer
    # TODO: raise exeption if timer is nil
    timer.comment(desc) if timer
  end

