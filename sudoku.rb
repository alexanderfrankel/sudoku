class Sudoku
  def initialize(string)
    @board = []
    string.split("").each_slice(9) { |row| @board << row }
  end

  def solve!
    p "GAME WON!" if place_num([0,0]) == true
    board
  end

  def place_num(location)

    if location[1] == 8
      next_location = [location[0]+1, 0]
    else
      next_location = [location[0], location[1]+1]
    end

    valid_nums(location).each do |num|
      @board[location[0]][location[1]] = num if @board[location[0]][location[1]].to_i == 0
      return true if next_location[0] == 9
      return true if place_num(next_location)
      @board[location[0]][location[1]] = 0
    end

    return false
  end

  def valid_nums(location)
    row_nums = []
    col_nums = []
    grid_nums = []
    all_nums = []

    row_nums = @board[location[0]]

    for row in 0..8
      col_nums << @board[row][location[1]]
    end

    grid_neighbors(location).each do |coord|
      grid_nums << @board[coord[0]][coord[1]]
    end

    all_nums = row_nums + col_nums + grid_nums
    all_nums.uniq!.reject! { |num| num == 0 }
    if @board[location[0]][location[1]].to_i != 0
      valid_nums = (1..9).to_a - all_nums.map!(&:to_i) + [@board[location[0]][location[1]].to_i]
    else
      valid_nums = (1..9).to_a - all_nums.map!(&:to_i)
    end
  end

  def grid_neighbors(location)
    grid_1 = [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]]
    grid_2 = [[0,3], [0,4], [0,5], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5]]
    grid_3 = [[0,6], [0,7], [0,8], [1,6], [1,7], [1,8], [2,6], [2,7], [2,8]]
    grid_4 = [[3,0], [3,1], [3,2], [4,0], [4,1], [4,2], [5,0], [5,1], [5,2]]
    grid_5 = [[3,3], [3,4], [3,5], [4,3], [4,4], [4,5], [5,3], [5,4], [5,5]]
    grid_6 = [[3,6], [3,7], [3,8], [4,6], [4,7], [4,8], [5,6], [5,7], [5,8]]
    grid_7 = [[6,0], [6,1], [6,2], [7,0], [7,1], [7,2], [8,0], [8,1], [8,2]]
    grid_8 = [[6,3], [6,4], [6,5], [7,3], [7,4], [7,5], [8,3], [8,4], [8,5]]
    grid_9 = [[6,6], [6,7], [6,8], [7,6], [7,7], [7,8], [8,6], [8,7], [8,8]]

    grids = [grid_1, grid_2, grid_3, grid_4, grid_5, grid_6, grid_7, grid_8, grid_9]
    grids.each do |grid|
      return grid if grid.include? location
    end
  end

  def complete?
    @board.flatten.each do |num|
      return false if num.to_i == 0
    end
    return true
  end

  def board
    @board.each do |row|
      puts row.join(" ")
    end
  end


end


earlier = Time.now
File.readlines('/Users/apprentice/Desktop/sudoku-2-guessing-challenge/source/set-04_peter-norvig_11-hardest-puzzles.txt').each do |line|
  board = line.chomp
  game = Sudoku.new(board)
  game.solve!
end
now = Time.now
puts "This solves all in #{now-earlier}"
