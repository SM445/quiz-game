# frozen_string_literal: true

module FileHandling
  def read_file(file_path)
    questions_and_answers = [] # empty 2d array to store question[0] and answer[1]

    begin
      File.open(file_path, 'r') do |file| # open file and iterate over file content
        file.each_line do |line| # read each line of the file
          content = line.chomp.split(',')
          question = content[0]
          answer = content[1]

          questions_and_answers << [question, answer]
        end
      end
    rescue Errno::ENOENT => e
      puts "Error: #{e.message} (File not found)"
    rescue Errno::EACCES => e
      puts "Error: #{e.message} (Permission denied)"
    rescue StandardError => e
      puts "Error: #{e.message} (Unknown error)"
    end

    questions_and_answers
  end
end
