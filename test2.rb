require_relative "board.rb"

class Solver


    def initialize
        @board = Board.new(Board.from_file("sudoku1.txt"))
        @pos = []
        @value = 0
        non_given = []
        (0..8).each do |i|
            (0..8).each do |j|
                @value = @board.grid[i][j].value
                if @board.grid[i][j].given == false
                    non_given << [i, j]
                end
            end
        end
        p non_given
    end

    def play
        # until @board.solved? do
            # system("clear")
            @board.render
            puts "Please enter a position and a chosen number separated with a space character (e.g. '1,2 8')"
            
            # backtracking(non_given[0], @board(non_given[o]).value)
            # prompt
        # end
        # system("clear")
        # @board.render
        puts "Congratulations you won!"
    end

    def row_violation?(pos, value)
            (0..8).each do |j|
                next if j == pos[1]
                return true if value == @board.grid[pos[0]][j].value
            end
        false
    end

    def coloumn_violation?(pos, value)
        (0..8).each do |i|
            next if i == pos[0]
            return true if value == @board.grid[i][pos[1]].value
        end
    false
    end

    def square_violation?(pos, value)
        k = pos[0] / 3 * 3
        l = pos[1] /3 * 3

        puts k
        puts l

        # (0..8).each do |i|
        #     (0..8).each do |j|
        #         next if i == pos[0] && j == pos[1]
        #             return true if value == @board.grid[i][j].value
        #         end
        #     end
        # end
        #     return true if value == @board.grid[i][pos[1]].value
        # false
    end

    def violation?(pos, value)
        return true if row_violation?(pos, value) || coloumn_violation?(pos, value) || square_violation?(pos, value)
    end
        
    # def backtracking(pos, value)
    #     value += 1
    #     while violation?(pos, value) && value < 9
    #         value += 1
    #     end
    #     if violation?(pos, value) && value == 9
    #         value = 0
    #         backtracking(previous_pos, inrement_by 1)
    #     else
    #         value = 1
    #         backtracking(next_pos, value)
    #     end
    # end




    def prompt
        pos_value = gets.chomp.split("")
        p pos_value
        pos_value
    end

    def valid?(pos_value)
        @pos = [pos_value[0].to_i, pos_value[2].to_i]
        p @pos
        @value = pos_value[4].to_i
        p @value
        return false if pos_value[1] != "," 
        return false if @pos.any? {|n| !(0..8).include?(n)}
        (1..9).include?(@value)
    end

end

game = Solver.new
game.play
# p game.row_violation?([0,0], 2)
p game.coloumn_violation?([0,0], 8)
p game.square_violation([3,7], 8)
    
