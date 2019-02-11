class BrainFuck

  attr_accessor :prog, :progPtr, :dataPtr, :dataArr, :jump

  def initialize(prog)
    self.prog = prog.to_s
    self.progPtr = 0
    self.dataPtr = 0
    self.dataArr = Array.new(30000, 0)
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
    while self.progPtr < self.prog.bytesize
      case self.prog[self.progPtr]
        when ">"
          self.dataPtr += 1
        when "<"
          self.dataPtr -= 1
        when "+"
          self.dataArr[self.dataPtr] += 1
        when "-"
          self.dataArr[self.dataPtr] -= 1
        when "."
          putc self.dataArr[self.dataPtr].chr
        when ","
          self.dataArr[self.dataPtr] = gets.to_i
        when "["
          self.progPtr = self.jump[self.progPtr] if self.dataArr[self.dataPtr] == 0
        when "]"
          self.progPtr = self.jump[self.progPtr] unless self.dataArr[self.dataPtr] == 0
      end
      self.progPtr += 1
    end
  end
  
end
