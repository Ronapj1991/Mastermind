module Game
  CODE_PEGS = ["red", "blue", "yellow", "green", "orange", "purple"]

  class DecodingBoard
    attr_accessor :code
    def initialize
      @code = ["column1", "column2", "column3", "column4"]
    end

    def displayCode
      puts "[#{@code[0]}] [#{@code[1]}] [#{@code[2]}] [#{@code[3]}]"
    end

    def computer_set_code
      comp_code = []
      puts "The computer is creating the code"
      until comp_code.length == 4
        comp_code.push(CODE_PEGS.sample)
      end
      puts "code created..."
      @code = comp_code
    end

    def check_positions(guess_arr)
      position = 0
      iterator = 0

      while (iterator < guess_arr.length)
        currentGuess = guess_arr[iterator]
        codeItem = @code[iterator]

        if currentGuess == codeItem
          position += 1
        end

        iterator += 1
      end

      puts "Number of correct positions: #{position}"
    end

    def check_colors(guess_arr)
      color = 0
      unique_colors = guess_arr.uniq
      unique_colors.each do |currentColor|
        color += code.count(currentColor)
      end
      
      puts "Number of correct colors: #{color}"
    end

    def player_win?(guess_arr)
      guess_arr == @code
    end

    def computer_guess
      #make a guess algo
    end
  end

  class Codemaker
    def initialize(name)
      @name = name
      @role = "Codemaker"
    end

    def set_code
      code = []
      puts "Create the code"
      column_index = 1
      until code.length == 4
        puts "Which color for column#{column_index}"
        puts "You can only choose from #{CODE_PEGS}"
        userInput = gets.chomp
        until CODE_PEGS.include?(userInput)
          puts "You can only choose from #{CODE_PEGS}"
          userInput = gets.chomp
        end
        code.push(userInput)
        column_index += 1
      end
      puts "code created..."
      code
    end
  end
  
  class Codebreaker
    attr_reader :name

    def initialize(name)
      @name = name
      @role = "Codebreaker"
    end

    def guess
      guess = []
      puts "\nGuess the code"
      column_index = 1
      until guess.length == 4
        puts "Which color for column#{column_index}"
        puts "You can only choose from #{CODE_PEGS}"
        userInput = gets.chomp.strip
        until CODE_PEGS.include?(userInput)
          puts "You can only choose from #{CODE_PEGS}"
          userInput = gets.chomp
        end
      guess.push(userInput)
      column_index += 1
      end
      
      guess
    end
  end

  puts %{
    Choose your role: 'Code(b)reaker' or 'Code(m)aker'
    b - Codebreaker
    m - Codemaker 
  }

  gameMode = (gets.chomp).downcase
  until ['b', 'm'].include?(gameMode)
    puts "The choices are either 'b' or 'm'"
    gameMode = (gets.chomp).downcase
  end

  if (gameMode == 'b')
    print "Enter your name: "
    player = Codebreaker.new(gets.chomp.strip)
    player = player
    board = DecodingBoard.new
    board.computer_set_code
    guess = []

    12.times do
      board.displayCode
      guess = player.guess
      board.check_positions(guess)
      board.check_colors(guess)

      if board.player_win?(guess)
        puts "\n #{player.name} wins"
        break
      end
    end
    
    unless board.player_win?(guess)
      puts "You failed this game..."
    end
  end

  if (gameMode == 'm')
    #continue tomorrow
  end
end