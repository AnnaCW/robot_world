require 'yaml/store'

class RobotRepository
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department]}
    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map {|data| Robot.new(data)}
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    database.transaction do
      target_robot = database['robots'].find { |data| data["id"]== id}
      target_robot["name"] = robot[:name]
      target_robot["city"] = robot[:city]
      target_robot["state"] = robot[:state]
      target_robot["avatar"] = robot[:avatar]
      target_robot["birthdate"] = robot[:birthdate]
      target_robot["date_hired"] = robot[:date_hired]
      target_robot["department"] = robot[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database["robots"].delete_if {|robot| robot["id"] == id }
      # database['total'] -= 1
    end
  end

  def delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end

  def birthday_strings
    database.transaction do
      birthday_strings = database["robots"].map { |robot| robot["birthdate"]}
    end
  end

  def average_age
    birthdates = birthday_strings.map {|date| date.split("/")}

    years = birthdates.map do |date|
      Time.mktime(date[2].to_i)
    end
    ages = years.map do |year|
      Time.now - year
    end
      (ages.reduce(:+)/ages.length/31536000).round
  end


  def robot_cities
    database.transaction do
      database["robots"].map { |robot| robot["city"]}
    end
  end

  def robots_per_city
    city_occurences = robot_cities.group_by do |city|
      city
    end
    city_occurences.map do |city, occurences|
      [city, occurences.count]
    end
  end

  def robot_states
    database.transaction do
      database["robots"].map { |robot| robot["state"]}
    end
  end

  def robots_per_state
    state_occurences = robot_states.group_by do |state|
      state
    end
    state_occurences.map do |state, occurences|
      [state, occurences.count]
    end
  end

  def robot_departments
    database.transaction do
      database["robots"].map { |robot| robot["department"]}
    end
  end

  def robots_per_department
    department_occurences = robot_departments.group_by do |department|
      department
    end
    department_occurences.map do |department, occurences|
      [department, occurences.count]
    end
  end

end
