# frozen_string_literal: true

# class for the board nodes
class Node
  attr_reader :location
  attr_accessor :children

  def initialize(location)
    @location = location
    @children = []
  end

  def add_children(helper = find_children_helper, location = @location)
    moves = []
    helper.each do |nums|
      moves[0] = location[0] + nums[0]
      moves[1] = location[1] + nums[1]
      @children << Node.new([moves[0], moves[1]]) unless moves[0].negative? || moves[1].negative?
    end
  end

  def find_children_helper
    [[-1, 2], [1, 2], [2, 1], [2, -1],
     [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  end
end
