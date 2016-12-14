require_relative "board"
require_relative "player"
require "pry"

class Connect4
  VALID_COLUMNS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
    get_players
  end

  def get_players
    puts "Welcome to Connect 4!"
    puts "What's the name of player 1?"
    player1_name = gets.chomp
    while player1_name == ""
      puts "Please enter a valid name."
      player1_name = gets.chomp
    end
    puts "Great! What character should #{player1_name}'s game piece to be?"
    player1_piece = gets.chomp
    while player1_piece == ""
      puts "Please enter a valid piece."
      player1_piece = gets.chomp
    end
    @player1 = Player.new(player1_name, player1_piece)

    puts "What's the name of player 2?"
    player2_name = gets.chomp
    while player2_name == "" || player2_name == player1_name
      puts "Please enter a valid name."
      player2_name = gets.chomp
    end
    puts "Great! What character should #{player2_name}'s game piece to be?"
    player2_piece = gets.chomp
    while player2_piece == "" || player2_piece == player1_piece
      puts "Please enter a valid piece."
      player2_piece = gets.chomp
    end
    @player2 = Player.new(player2_name, player2_piece)
    puts ""
  end

  def play
    winner = false
    while !winner
      if (board.full?)
        puts "Sorry, the board is completely full. Nobody wins! Try again."
        winner = true
        break
      end

      take_turn(@player1)
      if (@board.check_for_win)
        puts @board.print_board
        puts "#{@player1.name} wins!"
        winner = true
        break
      end

      take_turn(@player2)
      if (@board.check_for_win)
        puts @board.print_board
        puts "#{@player2.name} wins!"
        winner = true
        break
      end
    end
    puts "Would you like to play again? (Y/N)"
    play_again = gets.chomp.upcase
    if (play_again == "Y")
      @board = Board.new
      play
    end
    puts "Thanks for playing!"
  end

  def take_turn(player)
    puts @board.print_board
    print "#{player.name}'s turn: "
    column = gets.chomp.upcase

    while !VALID_COLUMNS.include?(column)
      puts "That is not a valid move. Please enter a valid column."
      column = gets.chomp.upcase
    end

    success = board
    .add_piece(column, player.piece)
    while !success
      puts "Sorry, that column is full. Please choose a different one."
      column = gets.chomp
      success = board.add_piece(column, player.piece)
    end
  end
end

game = Connect4.new
game.play
