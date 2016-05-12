require 'bundler'
Bundler.require

databases = [ Sequel.postgres("robot_repository"), Sequel.postgres("robot_repository_test")]

databases.each do |database|
  database.create_table :robots do
    primary_key :id
    String      :name, :size => 255
    String      :city, :size => 255
    String      :state, :size => 255
    String      :avatar, :size => 255
    String      :birthdate, :size => 255
    String      :date_hired, :size => 255
    String      :department, :size => 255  
  end
end
