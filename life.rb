class World
  attr_accessor :size, :terrain

  def initialize(x = 10,y = 10) 
    @size = [x,y] 

    @terrain = []
    y.times {@terrain << []}

    @terrain.each do |derp|
      x.times {derp << '* '}
    end
  end

  def print
    @terrain.each do |derp| 
      puts derp.join
    end
  end

  def test(x,y)


    neigh = 0
   

    if y < @terrain.length && x < @terrain[0].length
      neigh += 1 if @terrain[y+1][x+1] == "O "
    end

    unless y >= @terrain.length 
      neigh += 1 if @terrain[y+1][x] == "O "
      neigh += 1 if @terrain[y+1][x-1] == "O "
    end

    unless x >= @terrain[0].length 
      neigh += 1 if @terrain[y][x+1] == "O "
      neigh += 1 if @terrain[y-1][x+1] == "O "
    end

    neigh += 1 if @terrain[y-1][x] == "O "
    neigh += 1 if @terrain[y][x-1] == "O "
    neigh += 1 if @terrain[y-1][x-1] == "O "

    if @terrain[y][x] == "O "
      if neigh == 2 || neigh == 3
        return true
      else
        return false
      end
    elsif @terrain[y][x] != "O "
      if neigh == 3
        return true
      else
        return false
      end
    end
  end 

  def tick
    y = 0
    x = 0
    terraintemp = @terrain.clone

    until y == @terrain.length - 1
      until x == @terrain[0].length - 1
        if test(x,y)
          terraintemp[x][y] = "O "
        end
        x+=1
      end
      x=0
      y+=1
    end
    @terrain = terraintemp

  end

end

x = World.new
system("clear")
x.print
gets

x.terrain[4][5] = "O "
x.terrain[4][4] = "O "
x.terrain[4][6] = "O "

loop do
x.tick
x.print
sleep 0.5
end


p x.test(5,4)


x.print
gets

