desc 'Loads data from db/details.csv file to details table'
task :load_data => :environment do
  puts 'Starting to load...'
  
  Detail.import!

  puts 'Done loading!'
end