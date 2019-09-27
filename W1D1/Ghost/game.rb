require 'byebug'
require 'set'
class Game
    attr_accessor :fragment, :players, :dictionary, :current_player
   
    def initialize(list_of_players)
        words = File.readlines("dictionary.txt", chomp: true)
        @fragment = ""
        @players = list_of_players
        @dictionary = words.to_set
        @current_player = players[0]
    end

    def valid_play?(character)
        if character.length == 1 && character.count("a-zA-Z") == 1
            @fragment = fragment + character
            dictionary.each do |word|
                if word.index(fragment) == 0
                    return true
                end
            end
        else
            @current_player.alert_invalid_guess 
            return false
        end
    end

    def play_round 
        while !(valid_play?(@current_player.guess) && dictionary.subset(fragment.to_set))
            p "valid play, next players turn"
            @current_player = nextplayer!
        end
            p @current_player + "wins"
    end

    def current_player()
        @current_player
    end

    def previous_player()
        @players[(@players.index(@current_player))-1]
    end

    def nextplayer!()
        @players = @players[(@players.index(@current_player))+1]
    end

    def take_turn(player)
        @current_player.guess
    end

end
