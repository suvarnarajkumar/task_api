require 'csv'
class Detail < ApplicationRecord
  scope :building_type, ->(building_type) { where('lower(building_type) = ?', building_type.downcase) } 
  scope :beds_range, ->(min, max) { where('beds >= ? AND beds <= ?', min,max) } 
  scope :sq__ft_range, ->(min, max) { where('sq__ft >= ? AND sq__ft <= ?', min,max) } 
  
  def self.import!
    CSV.foreach(Rails.root.join('db/details.csv'), headers: true) do |row|
      break if Detail.count >= 985
      Detail.create! row.to_hash.slice('street','city','zip','state','beds','baths','sq__ft','building_type','sale_date','price','latitude','longitude')
      print '...'
    end
  end
end
