# frozen_string_literal: true

task :run do
  if ARGV.length < 2
    puts 'Usage: rake run input.txt'
    exit 1
  end

  file = ARGV[1]
  ruby "main.rb \"#{file}\""
end

task :run_default do
  ruby 'main.rb data/input.txt'
end

task :run_all do
  Dir.glob('data/*').each do |file|
    puts "\nDo you want to run file: \"#{file}\"? (y/n)"
    answer = $stdin.gets.chomp.downcase
    unless ['y', ''].include?(answer)
      puts 'Aborted.'
      exit(0)
    end
    ruby "main.rb \"#{file}\""
    puts "\nFile ran: #{file}"
  end
end

task :run_tests do
  Dir.glob('test/*').each do |file|
    result = `ruby \"#{file}\"`
    puts result.lines.last
  end
end

task default: :run_default
