require 'pry'
class TicTacToe
    attr_accessor :board

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        board[index] = token
    end

    def position_taken?(index)
        self.board[index] == " " ? false : true
    end

    def valid_move?(position)
        if position >= 0 && position <= 8 && self.position_taken?(position) == false
            true
        end
    end

    def turn_count
        @board.filter {|space| space != " "}.length
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Choose a position, 1-9."
        input = gets
        index = self.input_to_index(input)

        if self.valid_move?(index)
            move(index, self.current_player)
            display_board
        else
            turn
        end
    end

    def won?
        x_spaces = []
        o_spaces = []

        board.each_with_index do |space, index|
            if space == "X"
                x_spaces << index
            elsif space == "O"
                o_spaces << index
            end
        end

        i = 0 
        while i < WIN_COMBINATIONS.length
            if x_spaces.permutation(3).to_a.include?(WIN_COMBINATIONS[i]) || o_spaces.permutation(3).to_a.include?(WIN_COMBINATIONS[i])
                return WIN_COMBINATIONS[i]
            else
                i += 1
            end
        end
        false
    end

    def full?
        board.filter {|space| space == " "}.length == 0 ? true : false
    end

    def draw?
        full? && !won? ? true : false
    end

    def over?
        full? || won? || draw? ? true : nil
    end

    def winner
        x_spaces = []
        o_spaces = []

        board.each_with_index do |space, index|
            if space == "X"
                x_spaces << index
            elsif space == "O"
                o_spaces << index
            end
        end

        if x_spaces.permutation(3).to_a.include?(self.won?)
            "X"
        elsif o_spaces.permutation(3).to_a.include?(self.won?)
            "O"
        else
            nil
        end
    end

    def play
        until over? do
            turn
        end

        if won?
            puts "Congratulations #{self.winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end