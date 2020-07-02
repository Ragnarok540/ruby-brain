class BrainFuck

  attr_accessor :prog, :prog_ptr, :data_ptr, :data_arr, :jump

  def initialize(prog)
    self.prog = prog.to_s
    self.prog_ptr = 0
    self.data_ptr = 0
    self.data_arr = Array.new(30000, 0)
    self.jump = Array.new
  end

  def jumps
    stack = Array.new
    self.prog.chars.each_with_index do |item, index|
      case item 
        when "["
          stack.push(index)
        when "]"
          unless stack.at(-1) == nil
            self.jump[index] = stack.pop
            self.jump[self.jump[index]] = index
          else
            raise "Unmatched ] at #{index}"
          end
      end
    end
    raise "Unmatched [ at #{stack.at(-1)}" if stack.length > 0
  end
  
  def execute
    self.jumps
    while self.prog_ptr < self.prog.bytesize
      case self.prog[self.prog_ptr]
      when ">"
        self.data_ptr += 1
      when "<"
        self.data_ptr -= 1
      when "+"
        self.data_arr[self.data_ptr] += 1
      when "-"
        self.data_arr[self.data_ptr] -= 1
      when "."
        putc self.data_arr[self.data_ptr].chr
      when ","
        self.data_arr[self.data_ptr] = gets.to_i
      when "["
        if self.data_arr[self.data_ptr] == 0
          self.prog_ptr = self.jump[self.prog_ptr]
        end
      when "]"
        unless self.data_arr[self.data_ptr] == 0
          self.prog_ptr = self.jump[self.prog_ptr]
        end
      end
      self.prog_ptr += 1
    end
  end
  
end
