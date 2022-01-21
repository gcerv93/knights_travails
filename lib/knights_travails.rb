# frozen_string_literal: true

# class for the board nodes
class Node
  attr_reader :location, :parent
  attr_accessor :children

  def initialize(location, parent = nil)
    @location = location
    @children = []
    @parent = parent
  end

  def add_children(helper = find_children_helper, location = @location)
    moves = []
    helper.each do |nums|
      moves[0] = location[0] + nums[0]
      moves[1] = location[1] + nums[1]
      create_child([moves[0], moves[1]]) unless moves[0].negative? || moves[1].negative?
    end
  end

  def create_child(coords)
    @children << Node.new([coords[0], coords[1]], self)
  end

  def find_children_helper
    [[-1, 2], [1, 2], [2, 1], [2, -1],
     [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  end
end

# class for the Graph
class Graph
  attr_accessor :root, :visited

  def initialize(root)
    @root = root
    @visited = []
  end

  def find_path(end_point)
    queue = [@root]
    while queue
      node = queue.shift
      visited << node
      node.add_children
      break if node.location == end_point

      node.children.each { |n| queue << n unless visited.include?(n) }
    end
    node
  end
end

# class for the knight object
class Game
  attr_accessor :start_point, :end_point, :graph

  def initialize
    @start_point = nil
    @end_point = nil
  end

  def knight_moves(start_point, end_point)
    @start_point = create_graph(start_point)
  end

  def create_graph(start_node)
    start_node = Node.new(start_node)
    start_node.add_children
    @graph = Graph.new(start_node)
  end

  def format_path(node)
    parents = [node.location]
    until node.parent.nil?
      parent = node.parent
      node = parent
      parents << node.location
    end
    p parents.reverse
  end
end
