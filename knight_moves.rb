class KnightPos
  attr_accessor :pos, :goal, :parent, :children, :ttl

  def initialize(pos, goal, parent = nil, ttl = 7)
    @pos = pos
    @goal = goal
    @parent = parent
    @ttl = ttl
    #Time to live (ttl) based on # of moves req. to consistently inefficiently traverse board.
    @children = gen_moves
  end

  #Determines all possible valid moves from current position.
  def gen_moves
    return [] if @ttl == 0 || @pos == @goal
    #All possible knight moves.
    moves = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]
    move_list = []

    moves.each do |i|
      new_pos = [pos[0] + i[0], pos[1] + i[1]]
      #Checks that move is still on board and not doubling back on route.
      if trace.none?(new_pos) && new_pos in [0..7, 0..7]
        move_list << KnightPos.new(new_pos, @goal, self, @ttl - 1)
        break if new_pos == goal
      end
    end
    move_list
  end

  #Finds shortest path to goal out of all children.
  def shortest_path(shortest = nil)
    return self if @pos == @goal && (shortest.nil? || shortest.ttl < @ttl)
    return shortest if @children.empty?

    @children.each do |child|
      if child.pos == @goal && (shortest.nil? || shortest.ttl < child.ttl)
        shortest = child
        break
      else
        shortest = child.shortest_path(shortest)
      end
    end
    shortest
  end

  #Returns coordinate of each move made from starting node to this node.
  def trace
    curr_pos = self
    list = [curr_pos.pos]
    until curr_pos.parent.nil?
      curr_pos = curr_pos.parent
      list << curr_pos.pos
    end
    list.reverse
  end
end

def knight_moves(start = [0,0], goal = [7,7])
  knight = KnightPos.new(start, goal)
  trace = knight.shortest_path.trace
  puts "You made it from #{start} to #{goal} in #{trace.size - 1} moves:"
  puts "#{trace} \n"
end

knight_moves([0,0],[1,2]) #=> [[0, 0], [1, 2]]
knight_moves([0,0],[3,3]) #=> [[0, 0], [1, 2], [3, 3]]
knight_moves([3,3],[0,0]) #=> [[3, 3], [2, 1], [0, 0]]
knight_moves #=> [[0, 0], [2, 1], [4, 2], [6, 3], [4, 4], [6, 5], [7, 7]]
