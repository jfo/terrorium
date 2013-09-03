class World
  attr_accessor :size, :terrain

  def initialize(length = 10, height = 10) 
    @size = [length, height] 

    @terrain = []
      height.times {@terrain << []}

    @terrain.each do |derp|
      length.times {derp << '* '}
    end
  end

  def print
    @terrain.each do |derp| 
      puts derp.join
    end
  end

  def tick
    temparray = Marshal.load(Marshal.dump(@terrain)) 

    x = 0
    until x == @terrain.length
      y = 0 

      until y == @terrain[0].length
        neigh  = 0

        neigh += 1 if @terrain[(x+1)%10][(y+1)%10] == "# "
        neigh += 1 if @terrain[(x+1)%10][y-1] == "# "
        neigh += 1 if @terrain[(x+1)%10][y] == "# "

        neigh += 1 if @terrain[x-1][(y+1)%10] == "# "
        neigh += 1 if @terrain[x][(y+1)%10] == "# "
        neigh += 1 if @terrain[x-1][y] == "# "
        neigh += 1 if @terrain[x][y-1] == "# "
        neigh += 1 if @terrain[x-1][y-1] == "# "

        if @terrain[x][y] == "* "    
           if neigh == 3 
             temparray[x][y] = "# "

           end
         end

         if @terrain[x][y] == "# "
           if neigh == 2 || neigh == 3
             temparray[x][y] = "# "            
           else
             temparray[x][y] = "* "
           end
         end
         y += 1
       end
       x += 1
    end

    @terrain = temparray
    end
     

  end





x = World.new(20,20)

system("clear")
x.print
gets

x.terrain[4][5] = "# "
x.terrain[4][4] = "# "
x.terrain[4][6] = "# "

x.print

loop do
system("clear")
  x.tick
  x.print
sleep 1
end

