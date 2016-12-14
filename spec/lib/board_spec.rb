require "spec_helper"
require_relative "../../board"
require "pry"

RSpec.describe Board do
  let (:my_board) { Board.new }
  let (:my_board2) { Board.new }
  let (:my_board3) { Board.new }
  let (:columns) { ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]}

  describe "#initialize" do
    it "creates an array of 10 empty arrays" do
      first_column = my_board.board[0]

      expect(my_board.board.length).to eq(10)
      expect(first_column).to be_a(Array)
      expect(first_column.length).to eq(0)
    end
  end

  describe "#full?" do
    it "will return true if the board is full" do
      columns.each do |column|
        10.times do
          my_board.add_piece(column, "X")
        end
      end
      expect(my_board.full?).to be true
    end
  end

  describe "#add_piece" do

    it "will return false if the board is already full" do
      columns.each do |column|
        10.times do

          my_board.add_piece(column, "X")
        end
      end

      expect(my_board.add_piece("A", "X")).to be false
    end
    it "will return false if the column you chose is already full" do
      10.times do
        my_board2.add_piece("A", "X")
      end

      expect(my_board2.add_piece("A", "X")).to be false
    end

    it "returns true if you add a piece to an available column" do
      expect(my_board3.add_piece("A", "X")).to be true
    end

    it "correctly adds a piece to an empty column" do
      my_board.add_piece("A", "X")

      expect(my_board.board[0][0]).to eq("X")
    end
  end

  describe "#check_for_win" do
    it "returns nil if there's no  win" do
      expect(my_board.check_for_win).to eq(nil)
    end
    it "can accurately identify any type of win" do
      my_board.add_piece("A", "X")
      my_board.add_piece("B", "X")
      my_board.add_piece("C", "X")
      my_board.add_piece("D", "X")

      expect(my_board.check_for_win).to eq("X")

      my_board2.add_piece("C", "X")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")

      expect(my_board2.check_for_win).to eq("O")
    end
  end

  describe "#check_horizontal_wins" do
    it "returns nil if there's no horizontal win" do
      expect(my_board.check_horizontal_wins).to eq(nil)
    end

    it "can accurately identify horizontal wins" do
      my_board.add_piece("A", "X")
      my_board.add_piece("B", "X")
      my_board.add_piece("C", "X")
      my_board.add_piece("D", "X")

      my_board2.add_piece("B", "X")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("D", "X")
      my_board2.add_piece("E", "O")
      my_board2.add_piece("B", "O")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("D", "O")
      my_board2.add_piece("E", "O")

      expect(my_board.check_horizontal_wins).to eq("X")
      expect(my_board2.check_horizontal_wins).to eq("O")
    end
  end

  describe "#check_vertical_wins" do
    it "returns nil if there's no vertical win" do
      expect(my_board.check_vertical_wins).to eq(nil)
    end

    it "returns nil if there are only 3 in a row" do
      my_board3.add_piece("D", "1")
      my_board3.add_piece("D", "1")
      my_board3.add_piece("D", "1")

      expect(my_board.check_vertical_wins).to eq(nil)
    end

    it "returns nil if there are 4 pieces in a row but not all the same" do
      my_board3.add_piece("D", "1")
      my_board3.add_piece("D", "1")
      my_board3.add_piece("D", "1")
      my_board3.add_piece("D", "X")

      expect(my_board.check_vertical_wins).to eq(nil)
    end

    it "can accurately identify vertical wins" do
      my_board.add_piece("A", "X")
      my_board.add_piece("A", "X")
      my_board.add_piece("A", "X")
      my_board.add_piece("A", "X")

      my_board2.add_piece("C", "X")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")
      my_board2.add_piece("C", "O")

      expect(my_board.check_vertical_wins).to eq("X")
      expect(my_board2.check_vertical_wins).to eq("O")
    end
  end

  # describe "#show_piece" do
  #   it "shows the piece at a specific location given the column and the row" do
  #     my_board.add_piece("A", "X")
  #     my_board.add_piece("A", "X")
  #     my_board.add_piece("A", "X")
  #     my_board.add_piece("B", "O")
  #     my_board.add_piece("H", "X")
  #
  #     expect(my_board.show_piece(0, 0)).to eq("X")
  #     expect(my_board.show_piece(0, 2)).to eq("X")
  #     expect(my_board.show_piece(1, 0)).to eq("O")
  #     expect(my_board.show_piece(7, 0)).to eq("X")
  #   end
  # end

  describe "#print_board" do
    it "accurately prints the current state of empty board" do
      expected_board = ""
      10.times do
        expected_board += "|                   |\n"
      end
      expected_board += " A B C D E F G H I J \n"

      expect(my_board.print_board).to eq(expected_board)
    end
    it "accurately prints the  state of a board after some gameplay" do
      my_board.add_piece("A", "X")
      my_board.add_piece("A", "X")
      my_board.add_piece("A", "X")
      my_board.add_piece("B", "O")
      my_board.add_piece("H", "X")

      expected_board = ""
      7.times do
        expected_board += "|                   |\n"
      end
      expected_board += "|X                  |\n"
      expected_board += "|X                  |\n"
      expected_board += "|X O           X    |\n"
      expected_board += " A B C D E F G H I J \n"

      expect(my_board.print_board).to eq(expected_board)
    end
  end
end
