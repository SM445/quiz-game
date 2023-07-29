# frozen_string_literal: true

require_relative 'quiz'

file = 'problems.csv'
quiz1 = Quiz.new(file)
quiz1.start_quiz
