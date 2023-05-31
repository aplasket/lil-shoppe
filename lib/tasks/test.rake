namespace :custom_task do
  desc 'Prints "something" five times'
  task :something do
    5.times {puts "something"}
  end
end