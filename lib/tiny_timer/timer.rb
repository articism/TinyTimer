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

    attr_reader :start_time, :real_running_time

    def initialize
      @start_time = Time.now
      @step_count = 0
      @real_running_time = 0 # sum of the running time of all steps
    end

    # if no block given, should do nothing
    def step(desc='')
      if block_given?
        if @block_flag
          yield
        else
          @step_count += 1
          puts "#{@@leading}#{STEP_CHARS}#{@step_count}. #{desc} ... "
          @block_flag = true
          start = Time.now
          yield
          running_time = Time.now - start
          @block_flag = false
          @real_running_time += running_time
          puts "#{@@leading}#{STEP_CHARS}-- finished in #{running_time} seconds"
        end
      end
    end
    
    # use this method if you only want to print out something, do not create an empty step or timer
    def comment(desc='')
      puts "#{@@leading}#{STEP_CHARS}[ #{desc} ]" if desc.length > 0
    end
  end

end
