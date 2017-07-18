#6.4.2 The rescue keyword
print 'Enter a number:'
n = gets.to_i
begin
  result = 100/n
rescue
  puts "Your number didn't work. Was it zero?"
  exit
end
puts "100/#{n} is #{result}"

#Using rescue inside methods and code blocks

def open_user_file
  print "File to open: "
  filename = gets.chomp
  begin
    fh = File.open(filename)
  rescue
    puts "Couldn't open your file!"
    return
  end
  yield fh
  fh.close
end

#6.4.3 Raising exceptions explicitly
def fussy_method(x)
  raise ArgumentError, "I need a number under 10" unless x < 10
end
fussy_method(30)

# Can also rescue:
begin
  fussy_method(20)
rescue ArgumentError
  puts "That was not an accemptable number"
end

#Can also leave out first argument to raise and it will be a RuntimeError
def fussy_method_2(x)
  raise "I need a number under 10" unless x < 10
end
fussy_method_2(30)

# 6.4.4 Capturing an exception in a rescue clause
begin
  fussy_method(20)
rescue ArgumentError => e # assign exception object to variable
  puts "That was not an acceptable number"
  puts "Here's the backtrace for this exception:"
  puts e.backtrace # ask it to display its backtrace
  puts "And here's the exception object's message:"
  puts e.message # ask it to display its message
end

# 6.4.5 The ensure clause
