module TinyTimer
  TIMER_CHARS = ""
  STEP_CHARS = "|"  # the very first chars within each line of a timer
  INDENTING = STEP_CHARS + "   " # ahead of each step
  STEP_SEPARATOR = "      " # empty line between steps

  class Timer
    @@timers = []
    @@leading = ''  # what's actually ahead of each line

    class << self
      def run_timer(desc=nil, &block)
        # desc ||= Rake.application.last_description
        new_timer = self.new
        @@timers.push(new_timer)
        puts "#{@@leading}#{TIMER_CHARS}\033[1;32mStarted: \033[33m#{desc}\033[0m"
        @@leading += INDENTING #if self.count > 1
        yield
        @@leading.slice!(-INDENTING.size..-1) #if self.count > 1
        puts "#{@@leading}#{TIMER_CHARS}\033[1;32mFinished. \033[0mTotal running time: \033[1;32m#{Time.now - new_timer.start_time}\033[0m seconds"
        @@timers.pop
      end

      def count
        @@timers.size
      end

      def current_timer
        @@timers.last
      end
      
      def leading
        @@leading
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
        if @block_flag # nested step
          yield
        else
          puts @@leading+STEP_SEPARATOR if @step_count > 0
          @step_count += 1
          @@step_chars = "#{@step_count}) "
          puts "#{@@leading}\033[1;36m#{@@step_chars}\033[33m#{desc} ... \033[0m"
          @@leading += @@step_chars
          @block_flag = true
          start = Time.now
          yield
          running_time = Time.now - start
          @block_flag = false
          @real_running_time += running_time
          puts "#{@@leading}finished in \033[1;36m#{running_time}\033[0m seconds"
          @@leading = @@leading[0...-@@step_chars.size]
          
        end
      end
    end
    
    # use this method if you only want to print out something, do not create an empty step or timer
    def comment(desc='')
      puts "#{@@leading}/* #{desc} */" if desc.length > 0
    end
  end

end
