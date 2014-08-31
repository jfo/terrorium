@cells = []

def populate
end

def find_neighbors(coord)
    output = []
    [0,0,1,1,-1,-1].permutation(2).each do |x, y|
        output << [coord[0] + x, coord[1] + y]
    end
    output.uniq
end

def tick(world)
    old_world = Marshal.load(Marshal.dump(world))

    new_world = []

    world.each do |c|
        neighbors = find_neighbors(c)
        tally = (neighbors & world).length
        if tally == 2 || tally == 3
            new_world << c
        end
    end
end

p find_neighbors([0,0])
