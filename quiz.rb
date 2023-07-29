# frozen_string_literal: true

require 'timeout'
require_relative 'filehandling'

class Quiz
  include FileHandling

  def initialize(file)
    @file = file
    @questions = read_file(@file)
  end

  def start_quiz
    result = match_answers(@questions)
    print "\n\n"
    puts "Total questions in the quiz: #{@questions.count}"
    puts "Correct answers in the quiz: #{result}"
    puts "Invalid answers in the quiz: #{@questions.count - result}"
  end

  private

  def match_answers(array_questions)
    valid_answers = 0
    time_value = 0

    print 'PLease y/n to add time limit : '
    time_option = gets.chomp.downcase
    print "\n"

    if time_option == 'y'
      loop do
        print "\n Please enter the time limit (in seconds): \n"
        time_value = gets.chomp.to_i

        break if time_value.positive?

        print "\n"
        puts 'Invalid input. Time limit must be a positive number greater than 0.'
        print "\n"
      end
    else
      time_value = 30
    end

    puts "Please press 'Enter' to start the quiz"
    option_selected = gets

    if option_selected.ord == 10
      print "\n<-------------Quiz Timer Started------------------> \n \n"
      begin
        Timeout.timeout(time_value) do
          array_questions.each do |row|
            question = row[0]
            correct_answer = row[1]
            print " Question is  #{question} : "
            guessed_answer = $stdin.gets.chomp
            next unless guessed_answer == correct_answer

            valid_answers += 1
          end
        end
      rescue Timeout::Error
        print "\n \n <-------------Quiz Timer Finished------------------>"
      end
    end
    valid_answers
  end
end
