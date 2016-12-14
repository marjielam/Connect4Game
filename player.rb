# player class? should hold the player's piece and name?
# player move
#

class Player
  attr_reader :name, :piece
  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end
