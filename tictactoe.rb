class TicTacToe
  include Enumerable
  @@empty_board = ["\n   |   |   ", "-----------", "   |   |   ", "-----------", "   |   |   \n\n"]
  @@map_hash = {TL: " ", TC: " ", TR: " ", CL: " ", CC: " ", CR: " ", BL: " ", BC: " ", BR: " "}

  def initialize
    puts "\nWelcome to TicTacToe, players!\n\n"
    player_setup
    instructions
    start_game
  end

  def instructions
    puts "The player who succeeds in placing three of their markers in a \nhorizontal, vertical, or diagonal row wins the game.\n\n"
    puts "Indicate each move with one of the following 2-letter symbols (see move map for help):\n\n"
    puts "TL - top-left",
         "TC - top-center"
    puts 'TR - top-right'.ljust(30) + '   Move Map   '.rjust(30),
         'CL - center-left'.ljust(30) + ' TL | TC | TR '.rjust(30),
         'CC - center-center'.ljust(30) + '--------------'.rjust(30),
         'CR - center-right'.ljust(30) + ' CL | CC | CR '.rjust(30),
         'BL - bottom-left'.ljust(30) + '--------------'.rjust(30),
         'BC - bottom-center'.ljust(30) + ' BL | BC | BR '.rjust(30)
    puts "BR - bottom-right\n"
  end

  def player_setup
      puts "In the game of TicTacToe, typically 'X' or 'O' are chosen as markers but you may use any single character you wish"
      puts "Player 1, please enter your marker."
      @marker1 = get_marker
      puts "Player 2, please enter your marker."
      @marker2 = get_marker
      if @marker1 == @marker2
        puts "Players must have different markers. Please try again"
        player_setup
      end
  end

  def get_marker
    marker = gets.chomp
    validate_marker(marker)
  end
  def validate_marker(marker)
    until marker.length == 1
      puts "Invalid marker. Please enter only a SINGLE character.\n\n"
      marker = gets.chomp
    end
    return marker
  end
#ADD PLAY CLASS

    def start_game
      puts @@empty_board
      puts "Player 1, make your move by typing in a 2-letter code"
      get_move
    end

    def get_move
      move = gets.chomp
      validate_move(move.upcase.to_sym)
    end

    def validate_move(move)
      if @@map_hash[move] == nil || @@map_hash[move] == @marker1 || @@map_hash[move] == @marker2
        puts "Invalid input. Try again."
        get_move
      end
      insert_move(move)
    end

    def insert_move(move)
      @whos_move = defined?(@whos_move) ? @whos_move + 1 : 1
      @whos_move % 2 == 0 ? a = @marker2 : a = @marker1
      @@map_hash[move.to_sym] = a
      @@move_map = [" %{TL} | %{TC} | %{TR} " % @@map_hash,
                  "------------",
                  " %{CL} | %{CC} | %{CR} " % @@map_hash,
                  "------------",
                  " %{BL} | %{BC} | %{BR} " % @@map_hash]
      puts @@move_map
      winner(a)
      drawl
      puts @whos_move
      continue_play
    end

    def continue_play
      puts "next player, make your move."
      get_move
    end

    def winner(marker)
      hooray = "We have a Winner!! Do you want to play again?\n\nType 'Y' or 'N'"
      if (@@map_hash[:TL] == marker && @@map_hash[:TC] == marker && @@map_hash[:TR] == marker) ||
         (@@map_hash[:CL] == marker && @@map_hash[:CC] == marker && @@map_hash[:CR] == marker) ||
         (@@map_hash[:BL] == marker && @@map_hash[:BC] == marker && @@map_hash[:BR] == marker) ||
         (@@map_hash[:TL] == marker && @@map_hash[:CL] == marker && @@map_hash[:BL] == marker) ||
         (@@map_hash[:TC] == marker && @@map_hash[:CC] == marker && @@map_hash[:BC] == marker) ||
         (@@map_hash[:TR] == marker && @@map_hash[:CR] == marker && @@map_hash[:BR] == marker) ||
         (@@map_hash[:TL] == marker && @@map_hash[:CC] == marker && @@map_hash[:BR] == marker) ||
         (@@map_hash[:TR] == marker && @@map_hash[:CC] == marker && @@map_hash[:BL] == marker)
           puts hooray
           if gets.chomp.upcase == "Y"
                new_game
           else
            exit
           end
      else
        return
      end
    end
    def new_game
      @@map_hash = {TL: " ", TC: " ", TR: " ", CL: " ", CC: " ", CR: " ", BL: " ", BC: " ", BR: " "}
      remove_instance_variable(:@marker1)
      remove_instance_variable(:@marker2)
      remove_instance_variable(:@whos_move)
      player_setup
      start_game
    end

    def drawl
      if @whos_move == 9
        puts "We have a drawl! Would you like to play again?\n\nType 'Y' or 'N'"
        if gets.chomp.upcase == "Y"
                new_game
        else
            exit
        end
      end
    end
end


TicTacToe.new
