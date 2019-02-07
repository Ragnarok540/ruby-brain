class BrainFuck

  def initialize(program)
    @program = program
    @pointer = 0
    @array = Array.new(30000, 0)
  end
  
  def pointer?
    puts "Pointer is #@pointer"
  end
  
  def program?
    puts "Program is #@program"
  end
  
  def array?
    puts "Array is #@array"
  end
    
  def incPointer
    @pointer = @pointer + 1
  end
  
  def decPointer
    @pointer = @pointer - 1
  end
  
  def incCell
    @array[@pointer] = @array[@pointer] + 1
  end
  
  def decCell
    @array[@pointer] = @array[@pointer] - 1
  end
  
  def output
    puts @array[@pointer].chr
  end
  
  def input
    @array[@pointer] = gets.to_i
  end
  
end

bf = BrainFuck.new("[->+<]")

bf.incPointer
bf.incCell
bf.pointer?
bf.program?
bf.output
bf.incPointer
bf.input
bf.output
bf.array?
