# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './player'
require './question'


#REPL + game logic
@game = true
#0 for p1 1 for p2
@turn = 0

puts

print 'Player 1 name: '
@username = gets.chomp
p1 = Player.new(@username)
p1.name = p1.name
print 'Player 2 name: '
@username = gets.chomp
p2 = Player.new(@username)
p2.name = p2.name

puts

while @game

  question = Question.new

  case @turn
  when 0
    print "#{p1.name}: "
  else
    print "#{p2.name}: "
  end

  print question.opening
  @user_input = gets.chomp.to_i

  if @turn == 0 && question.is_correct?(@user_input)
    puts "yes"
    p1.gain_point
    @turn += 1
  elsif @turn == 0 && !question.is_correct?(@user_input)
    puts "nope"
    p1.lose_life
    @turn += 1
  elsif @turn == 1 && question.is_correct?(@user_input)
    puts "aight"
    p2.gain_point
    @turn -= 1
  elsif @turn == 1 && !question.is_correct?(@user_input)
    puts "nah"
    p2.lose_life
    @turn -= 1
  end

  puts
  puts "The score is:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} REMAINING LIVES
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} REMAINING LIVES"
  puts

  if p1.lives < 1 || p2.lives <1
    puts "every thing finshes at some point"
    if p1.lives < 1
      puts "The questionable winner is #{p2.name}"
    elsif p2.lives < 1
      puts "The questionable winner is #{p1.name}"
    end

    puts "The final score was:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} REMAINING LIVES
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} REMAINING LIVES"

    @game = false
  end

end
