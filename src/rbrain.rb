class BrainFuck

  def initialize(program)
    @prog = program.to_s
    @progPtr = 0
    @dataPtr = 0
    @dataArr = Array.new(30000, 0)
    @stack = Array.new
    @jump = Array.new
  end
  
  def dataPtr?
    puts "Data Pointer is #@dataPtr"
  end
  
  def progPtr?
    puts "Program Pointer is #@progPtr"
  end
  
  def program?
    puts "Program is #@prog"
  end
  
  def dataArr?
    puts "Data Array is #@dataArr"
  end
  
  def jump?
    puts "Jump Stack is #@jump"
  end
    
  def incDataPtr
    @dataPtr = @dataPtr + 1
  end
  
  def decDataPtr
    @dataPtr = @dataPtr - 1
  end
  
  def incCell
    @dataArr[@dataPtr] = @dataArr[@dataPtr] + 1
  end
  
  def decCell
    @dataArr[@dataPtr] = @dataArr[@dataPtr] - 1
  end
  
  def output
    putc @dataArr[@dataPtr].chr
  end
  
  def input
    @dataArr[@dataPtr] = gets.to_i
  end
  
  def startLoop
    @progPtr = @jump[@progPtr] if @dataArr[@dataPtr]  == 0
  end
  
  def endLoop
    @progPtr = @jump[@progPtr] unless @dataArr[@dataPtr] == 0
  end
  
  def jumps
    @prog.chars.each_with_index do |item, index|
      case item 
        when "["
          @stack.push(index)
        when "]"
          @jump[index] = @stack.pop
          @jump[@jump[index]] = index
      end
    end
  end
  
  def execute
    self.jumps
    while @progPtr < @prog.bytesize
      instruction = @prog[@progPtr]
      case instruction
        when ">"
          self.incDataPtr
        when "<"
          self.decDataPtr
        when "+"
          self.incCell
        when "-"
          self.decCell
        when "."
          self.output
        when ","
          self.input
        when "["
          self.startLoop
        when "]"
          self.endLoop
      end
      @progPtr = @progPtr + 1
    end
  end
end

bf = BrainFuck.new("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")

bf.execute
