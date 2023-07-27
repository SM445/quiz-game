# frozen_string_literal: true

require 'timeout'

def read_file(file_path)
  questions_and_answers = [] # empty 2d array to store question[0] and answer[1]
  # questions_count = 0

  File.open(file_path, 'r') do |file| # open file and iterate over file content
    file.each_line do |line| # read each line of the file
      # content=line.split(",").map(&:to_i)
      # content=line.chomp.split('','') #split when file , in each line

      content = line.chomp.split(',')

      question = content[0]
      answer = content[1]

      # questions_count += 1

      questions_and_answers << [question, answer.to_i] # can be questions_and_answers << [content[0],content[1]] , write question and their respective answer in 2d array
    end
  end

  questions_and_answers
  # return questions_count

  #
  # <-------Display array contents as they are in correct format------>
  #
  #   questions_and_answers.each do |file_result|
  #     question, answer = file_result
  #     puts "Question : #{question}"
  #     puts "Answer : #{answer}"
  #     puts "---------"
  #   end
  #
end

def match_answers(questions_answer_array)
  valid_answers = 0

  print 'PLease y/n to add time limit : '

  time_option = gets.chomp

  if time_option == ('y' || 'Y')

    print 'PLease enetr time limit : '

    time_value = gets.chomp

  else

    time_value = 30

  end

  puts "Please press 'Enter' to start the quiz"

  option_selected = gets

  if option_selected.ord == 10

    print "\n"
    puts '<-------------Quiz Timer Started------------------> '
    print "\n"
    print "\n"

    begin
      Timeout.timeout(time_value.to_i) do
        # puts "time_value #{time_value}: "

        questions_answer_array.each do |row|
          question = row[0]
          correct_answer = row[1]

          # start = Time.now
          # puts (Time.now - start).round # => prints 0

          print " Question is  #{question} : "

          guessed_answer = $stdin.gets.chomp

          # puts guessed_answer
          # puts correct_answer

          next unless guessed_answer.to_i == correct_answer

          valid_answers += 1

          # puts"Correct"

          # else

          # puts "Incorrect! The correct answer is #{correct_answer}."

          # puts (Time.now - start).round
        end
      end
    rescue Timeout::Error
      print ' <-------------Quiz Timer Finished------------------>'
    end

  end

  valid_answers
end

file = 'problems.csv'

questions = read_file(file) # Saves question / answer in array and outputs the array

result = match_answers(questions) # Outputted array is passed to this function to match the answers and tell about the number of correct answers

print "\n"
print "\n"
puts " Total questions in quiz : #{questions.count}"
puts " Correct answers in quiz : #{result}"
puts " Invalid answers in quiz : #{questions.count - result}"
