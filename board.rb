class Board
  attr_reader :board

   COLUMN_MAP = {
     A: 0,
     B: 1,
     C: 2,
     D: 3,
     E: 4,
     F: 5,
     G: 6,
     H: 7,
     I: 8,
     J: 9
   }

  def initialize
    @board = Array.new(10) { Array.new }
  end

  def add_piece(column_char, piece)
    column = COLUMN_MAP[column_char.upcase.to_sym]
    if (@board[column].length < 10)
      @board[column] << piece
      return true
    else
      return false
    end
  end

  def check_for_win
    if check_horizontal_wins
      check_horizontal_wins
    elsif check_vertical_wins
      check_vertical_wins
    else
      nil
    end
  end

  def check_horizontal_wins
    winning_streak = 1
    last_char = ""
    (0..9).each do |row|
      (0..9).each do |column|
        if (@board[column][row].nil?)
          winning_streak = 0
        elsif (@board[column][row] == last_char)
          winning_streak += 1
        else
          last_char = @board[column][row]
          winning_streak = 1
        end
        if (winning_streak == 4)
          return last_char
        end
      end
    end
    nil
  end

  def check_vertical_wins
    winning_streak = 1
    last_char = ""
    (0..9).each do |column|
      (0..9).each do |row|
        if (@board[column][row].nil?)
          winning_streak = 0
        elsif (@board[column][row] == last_char)
          winning_streak += 1
        else
          last_char = @board[column][row]
          winning_streak = 1
        end
        if (winning_streak == 4)
          return last_char
        end
      end
    end
    nil
  end

  def print_board
    printout = ""
    row = 9
    while (row >= 0) do
      printout += "|"
      column = 0
      while (column < 10) do
        if @board[column][row].nil?
          char = " "
        else
          char = @board[column][row]
        end
        if (column == 9)
          printout += "#{char}"
        else
          printout += "#{char} "
        end
        column += 1
      end
      printout += "|\n"
      row -= 1
    end
    printout += " A B C D E F G H I J \n"
    return printout
  end

  def full?
    @board.each do |column|
      if column.length < 10
        return false
      end
    end
      return true
  end

end
