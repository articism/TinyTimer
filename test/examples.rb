# since I'm too naive to know how to test with the $stdout, this is a sample ruby script playing with tiny_timer :-p

require 'tiny_timer'

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
end