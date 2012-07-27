class Operator < ActiveRecord::Base
  # attr_accessible :title, :body
  establish_connection "jim_#{Rails.env}"
  MORE_COMBOS = [".", "<", "(", "+", "|", "&", "!", "$", "*", ")", ";", "-", "/", ",", "%", "_", 
      ">", "?", "`", ":", "#", "@", "'", "=", "~", "^", "[", "]", "{", "}", 
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def self.load_operators
    "A".upto("z") do |a| 
      "A".upto("z") do |b| 
        Operator.new(:operator_id=> "#{a}#{b}").save
      end
    end
  end

  def self.do_some_more
    MORE_COMBOS.each do |a| 
      MORE_COMBOS.each do |b| 
        Operator.new(:operator_id=> "#{a}#{b}").save
      end
      "A".upto("z") do |b| 
        Operator.new(:operator_id=> "#{a}#{b}").save
      end
    end
    "A".upto("z") do |a| 
      MORE_COMBOS.each do |b| 
        Operator.new(:operator_id=> "#{a}#{b}").save
      end
    end
  end
end

