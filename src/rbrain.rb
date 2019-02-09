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
    puts "Jump Array is #@jump"
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
      case @prog[@progPtr]
        when ">"
          @dataPtr = @dataPtr + 1
        when "<"
          @dataPtr = @dataPtr - 1
        when "+"
          @dataArr[@dataPtr] = @dataArr[@dataPtr] + 1
        when "-"
          @dataArr[@dataPtr] = @dataArr[@dataPtr] - 1
        when "."
          putc @dataArr[@dataPtr].chr
        when ","
          @dataArr[@dataPtr] = gets.to_i
        when "["
          @progPtr = @jump[@progPtr] if @dataArr[@dataPtr] == 0
        when "]"
          @progPtr = @jump[@progPtr] unless @dataArr[@dataPtr] == 0
      end
      @progPtr = @progPtr + 1
    end
  end
  
end

bf = BrainFuck.new("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")

bf.execute
