class Earth 
  attr_accessor :terrain, :size

  def initialize(x = 60, y = 20)
    @size = [x,y]
    @terrain = []

    y.times do 
      @terrain << []
    end

    @terrain.each do |this|
      x.times do
         this << [' ']
      end
    end
  end

  def print
#    system ("clear")
    @terrain.each do |this|
      puts this.join
    end
  end

  def populate(pop = @size.inject(:*)/2)
    pop.times do 
      i = rand(1..@terrain.length-1)
      b = rand(1..@terrain[1].length-1)
      @terrain[i][b] = '#'
    end
    self
  end

  def test(x,y)

    neigh  = 0

    neigh += 1 if @terrain[x+1][y] == "#"
    neigh += 1 if @terrain[x][y+1] == "#"
    neigh += 1 if @terrain[x-1][y] == "#"
    neigh += 1 if @terrain[x][y-1] == "#"
    neigh += 1 if @terrain[x+1][y+1] == "#"
    neigh += 1 if @terrain[x+1][y-1] == "#"
    neigh += 1 if @terrain[x-1][y+1] == "#"
    neigh += 1 if @terrain[x-1][y-1] == "#"

    if @terrain[x][y] == "#"
      if neigh == 2 || neigh == 3
        return true
      else
        return false
      end

    elsif @terrain[x][y] == " "  
      if neigh == 3
        return true
      else
        return false
      end
    end

  end

  def tick
    terrainclone = @terrain.clone

    width = (@terrain[1].length) - 1
    height = (@terrain.length) - 1

    x = 0
    y = 0
    
    until y == width
      until x == height
        if test(x,y) == true 
          terrainclone[x][y] = "#"
        elsif test(x,y) == false
          terrainclone[x][y] = " "
        end
      x += 1
      end
    y+= 1
    x = 0
    end

    @terrain = terrainclone
    self

  end
end

class Critter
  attr_accessor :age, :loc

  def initialize
    @age = 0
    @loc = 0 
  end
end


x = Earth.new(10,10)
x.terrain[5][4] = "#"
x.terrain[5][5] = "#"
x.terrain[5][6] = "#"
x.print
gets

loop do
x.print
sleep 0.5

x.tick
end
