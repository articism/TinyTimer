module TinyTimer
  # User Interface (global convenience methods)
  module DSL
    
    private
    
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
    
    # overwrite **puts**, prepending the leading characters 
    def puts(*arg)
      print TinyTimer::Timer.leading
      super(*arg)
    end
    
  end
end
