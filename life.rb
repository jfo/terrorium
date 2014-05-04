#!/usr/bin/env ruby

class World
  attr_accessor :size, :terrain

  def initialize(length = 10, height = 10)
    @length = length
    @height = height

    @size = [length, height]
    @terrain = []
      height.times {@terrain << []}
    @terrain.each do |derp|
      length.times {derp << '  '}
    end
  end

  def print
    @terrain.each do |derp|
      puts derp.join
    end
  end

  def pop(x = 20)
    x.times do
      @terrain[rand(@height)][rand(@length)] = "# "
    end
  end


  def tick
    temparray = Marshal.load(Marshal.dump(@terrain))

    x = 0
    until x == @terrain.length
      y = 0

      until y == @terrain[0].length
        neigh  = 0

        neigh += 1 if @terrain[(x+1)% @height][(y+1) % @length] == "# "
        neigh += 1 if @terrain[(x+1)% @height][y-1] == "# "
        neigh += 1 if @terrain[(x+1)% @height][y] == "# "

        neigh += 1 if @terrain[x-1][(y+1) % @length] == "# "
        neigh += 1 if @terrain[x][(y+1) % @length] == "# "
        neigh += 1 if @terrain[x-1][y] == "# "
        neigh += 1 if @terrain[x][y-1] == "# "
        neigh += 1 if @terrain[x-1][y-1] == "# "

        if @terrain[x][y] == "  "
           if neigh == 3
             temparray[x][y] = "# "

           end
         end

         if @terrain[x][y] == "# "
           if neigh == 2 || neigh == 3
             temparray[x][y] = "# "
           else
             temparray[x][y] = "  "
           end
         end
         y += 1
       end
       x += 1
    end

    @terrain = temparray
  end
end


x = `tput cols`.to_i
y = `tput lines`.to_i
pop = ((x*y) * 0.8).to_i
pop = ((x*y) *  0.2).to_i

x = World.new(x/2, y)

x.pop(pop)
x.print

if ARGV[0]
  sleeptime = ARGV[0].to_f
else
  sleeptime = 0.1
end

loop do
  system("clear")
  x.tick
  x.print
  sleep sleeptime
end
