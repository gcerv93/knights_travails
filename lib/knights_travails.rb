# frozen_string_literal: true

# class for the board nodes
class Node
  attr_reader :location
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
    @children << Node.new([coords[0], coords[1]], location)
  end

  def find_children_helper
    [[-1, 2], [1, 2], [2, 1], [2, -1],
     [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  end
end

# class for the Graph
class Graph
  attr_accessor :root

  def initialize(root)
    @root = root
    @visited = []
  end
end

# class for the knight object
class Game
  attr_accessor :start_point, :end_point, :graph

  def initialize
    @start_point = nil
    @end_point = nil
  end

  def knight_moves(start_point)
    @start_point = create_graph(start_point)
  end

  def create_graph(start_node)
    start_node = Node.new(start_node)
    start_node.add_children
    graph = Graph.new(start_node)
    @graph = graph.root
  end
end
