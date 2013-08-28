class Earth 
  attr_accessor :terrain, :size

  def initialize(x = 60, y = 20)
    @size = [x,y]
    @terrain = []
    bound = []
    (x+2).times do 
      bound << "-"
    end

    y.times do 
      @terrain << []
    end

    @terrain.each do |this|
      this << "|"
      x.times do
         this << [' ']
      end
      this << "|"
    end
    @terrain.push(bound)
    @terrain.unshift(bound)
  end

  def print
    system ("clear")

    @terrain.each do |this|
      puts this.join
    end
  end

  def populate(pop = @size.inject(:*)/2)
    pop.times do 
      i = rand(1..20)
      b = rand(1..60)
      @terrain[i][b] = '.'
    end
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

loop do
x= Earth.new

x.populate(rand(40)*rand(20))
x.print
sleep 2
end

