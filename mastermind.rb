module Game
  CODE_PEGS = ["red", "blue", "yellow", "green", "orange", "purple"]

  class DecodingBoard
    attr_accessor :code, :guess
    def initialize
      @code = Array.new(4, "column")
      @guess = Array.new(4, "column")
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
        current_guess = guess_arr[iterator]
        code_item = @code[iterator]

        if current_guess == code_item
          position += 1
        end

        iterator += 1
      end

      puts "Number of correct positions: #{position}"
    end

    def check_colors(guess_arr)
      color = 0
      unique_colors = guess_arr.uniq
      unique_colors.each do |current_color|
        if guess_arr.count(current_color) < code.count(current_color)
          color += guess_arr.count(current_color)
        elsif guess_arr.count(current_color) >= code.count(current_color)
          color += code.count(current_color)
        end
      end
      
      puts "Number of correct colors: #{color}"
    end

    def player_win?(guess_arr)
      guess_arr == @code
    end

    def computer_guess(code_to_guess)
      iterator = 0

      while iterator < code_to_guess.length
        if @guess[iterator]!= code_to_guess[iterator]
          @guess[iterator] = CODE_PEGS.sample
        end
        
        iterator += 1
      end
    end
  end

  class Codemaker
    attr_accessor :code

    def initialize(name)
      @name = name
      @role = "Codemaker"
      @code = Array.new(4)
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
      @code = code
    end

    def num_of_tries
      choices = [8, 10, 12]
      puts "How many tries would you like to give the computer?"
      print "Choices are 8, 10, 12: "
      user_input = gets.chomp
      until (choices.include?(user_input.to_i))
        print "Choices are 8, 10, 12: "
        user_input = gets.chomp
      end

      user_input.to_i
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

  game_mode = (gets.chomp).downcase
  until ['b', 'm'].include?(game_mode)
    puts "The choices are either 'b' or 'm'"
    game_mode = (gets.chomp).downcase
  end

  if (game_mode == 'b')
    print "Enter your name: "
    player = Codebreaker.new(gets.chomp.strip)
    board = DecodingBoard.new
    board.computer_set_code
    guess = []

    12.times do
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
      puts "The code was: "
      board.displayCode
    end
  end

  if (game_mode == 'm')
    print "Enter your name: "
    player = Codemaker.new(gets.chomp.strip)
    board = DecodingBoard.new
    player.set_code
    puts "The code to play for: #{player.code}"
    tries = player.num_of_tries

    tries.times do
      board.computer_guess(player.code)
      puts "Computer guessed: #{board.guess}"
      if board.guess == player.code
        puts "The computer guessed the code!"
        break
      end
    end

    unless board.guess == player.code
      puts "The computer failed to guess the code..."
      puts "#{player.name} wins!"
    end
  end
end