require "csv"

class EventReporter

  def initialize
    @queue = []
  end

  def run
    puts "Welcome to Event Reporter!"
    command = ""
    
    while command != "quit"
      printf "Enter command: "
      command = gets.chomp
      command_parts = command.split

      case command_parts.first
        when "find"
          puts "Finding"
          # when first part of array is "find", split it into ONLY 3 parts
          parts = command.split(" ",3)
          # only run find method on 2nd and 3rd parts of array (field, input)
          find(parts[1],parts[2])
        when "quit"
          puts "Goodbye!"
        when "queue"
          if command_parts[1] == "count"
            puts "There are #{queue_count} items in the queue."          
          elsif command_parts[1] == "clear"
            queue_clear
            puts "Your queue is clear. There are now #{queue_count} items in the queue."
          end
        when "help"
          if command_parts.length == 1
            puts commands.keys
          else
            help_for_command = command_parts[1..-1].join(" ")
            puts commands[help_for_command]
          end        
      end
    end
  end

  def load_file
    @contents = CSV.read "event_attendees.csv", headers: true, header_converters: :symbol
  end

  def find(field, input)
    @queue.clear
    load_file
    #make input downcase to match the output that we will downcase
    input = input.downcase!
    #convert field to a symbol because we want it to be dynamic and auto downcased
    field = field.to_sym
    #for each row in csv (contents), find the specified field and search for specified input
    #if specified input exists in specified field, place row into queue
    @contents.each do |row|
      if row[field].downcase == input
        @queue << row
      # @queue << row if row[field].downcase == input
      puts "Found: #{row}" 
      end
    end  
  end

  def queue_count
    @queue.length
  end

  def queue_clear
    @queue.clear
  end

  def queue_print
    puts @contents
  end

  def clean_zipcode
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def commands
    {"queue clear" => "Clears your queue", 
     "queue count" => "Gives number of items in queue",
     "queue print" => "Displays items in queue",
     "find" => "Finds the attribute inputted and adds that row to the queue"}
  end  
end

e = EventReporter.new
e.run