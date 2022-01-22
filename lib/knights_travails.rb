# frozen_string_literal: true

# class for the board nodes
class Node
  attr_reader :location, :parent
  attr_accessor :children

  # initialize a node with a location and a parent set to nil for the root node of a graph
  def initialize(location, parent = nil)
    @location = location
    @children = []
    @parent = parent
  end

  # add children to a node using the children_helper method, making sure no moves
  # fall outside of the board
  def add_children(helper = find_children_helper, location = @location)
    moves = []
    helper.each do |nums|
      moves[0] = location[0] + nums[0]
      moves[1] = location[1] + nums[1]
      create_child([moves[0], moves[1]]) unless moves[0].negative? || moves[1].negative?
    end
  end

  # create the child with its parent attribute set as current node
  def create_child(coords)
    @children << Node.new([coords[0], coords[1]], self)
  end

  # method to help find the legal moves a knight can make
  def find_children_helper
    [[-1, 2], [1, 2], [2, 1], [2, -1],
     [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  end
end

# class for the Graph
class Graph
  attr_reader :root
  attr_accessor :visited

  def initialize(root)
    @root = root
    @visited = []
  end

  # find the path to the end_point using breadth first search
  def find_path(end_point)
    queue = [@root]
    while queue
      node = queue.shift
      break if node.location == end_point

      # send every node being processed to the visited array
      visited << node
      node.add_children

      # enqueue node children if they haven't been visited yet
      node.children.each { |child| queue << child unless visited.include?(child) }
    end
    node
  end

  # follow path back up from end_node to the first parent
  def find_parents(end_node)
    parents = [end_node.location]
    until end_node.parent.nil?
      parent = end_node.parent
      end_node = parent
      parents << end_node.location
    end
    parents.reverse
  end
end

# class for the knight object
class Game
  attr_accessor :graph

  def knight_moves(start_point, end_point)
    @graph = create_graph(start_point)
    end_node = graph.find_path(end_point)
    format_results(graph.find_parents(end_node))
  end

  # create the graph with the starting node, and its children
  def create_graph(start_node)
    start_node = Node.new(start_node)
    start_node.add_children
    Graph.new(start_node)
  end

  # format the results to print
  def format_results(parents)
    puts "You made it in #{parents.length - 1} moves! Here's your path:"
    parents.each { |parent| p parent }
  end
end
