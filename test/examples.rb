# since I'm too naive to know how to test with the $stdout, this is a sample ruby script playing with tiny_timer :-p
$:.push File.expand_path("../../lib", __FILE__)
require 'tiny_timer'

def nested_1
  timer "(nested_1) yielding some block" do
    step 'do something first' do
      10000.times do |i|
        i + 2
      end
    end
    yield
    step 'do something afterwards' do
      step 'a nested step will be neglected, although the code in the block will still run' do # do not do this!
        puts 'another screwing output'
      end
      10000.times do |i|
        i + 2
      end
    end
  end
end

# a normal piece of code
timer 'how long does 10000 calculations take ?' do
  step 'plusing' do
    10000.times do |i|
      i + 2
    end
  end
  step 'multipying' do
    10000.times do |i|
      i*33
    end
  end
  step 'dividing' do
    10000.times do |i|
      1000/(i+1)
    end
  end
  step 'if no block passed, should not crash and should print nothing'
  nested_1 { puts "if any code prints something, it will screw things up"}
  comment 'should be the end?'
end
