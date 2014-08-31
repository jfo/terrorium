def populate
    cells = []
    10.times do
        cells << [rand(9),rand(9)]
    end
    return cells
end

def find_neighbors(coord)
    output = []
    [0,0,1,1,-1,-1].permutation(2).each do |x, y|
        output << [coord[0] + x, coord[1] + y]
    end
    output.uniq
end

def try_dead_cell(cell, world)
    neighbors = find_neighbors(cell)
    tally = (neighbors & world).length
    return true if tally == 3
end

def tick(world)
    old_world = Marshal.load(Marshal.dump(world))
    new_world = []

    world.each do |living_cell|
        neighbors = find_neighbors(living_cell)
        dead_neighbors = neighbors - world

        dead_neighbors.each do |c|
            new_world << c if try_dead_cell(c, world)
        end

        tally = (neighbors & world).length
        new_world << living_cell if tally == 2 || tally == 3
    end
    new_world.uniq
end

x = populate
p x
loop do 
    p x = tick(x)
    gets
end

