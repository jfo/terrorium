def populate
    cells = []
    100.times do
        cells << [rand(10..30),rand(10..30)]
    end
    return cells
end

def find_neighbors(coord)
    deltas = [[0, 1],
              [0, -1],
              [1, 0],
              [-1, 0],
              [1, 1],
              [-1, -1],
              [1, -1],
              [-1, 1]]

    output = []

    deltas.each do |x, y|
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

def print_world(world)
    out = []
    (0..40).each do |y|
        out[y] = []
        (0..40).each do |x|
            if world.include?([x,y])
                out[y] << "▓ "
            else
                out[y] << "  "
            end
        end
        out[y] << "\n"
    end
    print out.join
end



x = populate
loop do 
    print_world x
    x = tick(x)
    sleep 0.01
end

