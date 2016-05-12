class RobotRepository
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    table.insert(name: robot[:name], city: robot[:city], state: robot[:state], avatar: robot[:avatar], date_hired: robot[:date_hired], department: robot[:department])
  end

  def table
    database.from(:robots).order(:id)
  end

  def all
    table.to_a.map {|robot| Robot.new(robot)}
  end

  def raw_robot(id)
    table.where(:id => id).to_a.first
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    locate_robot(id).update(robot)
  end

  def destroy(id)
    locate_robot(id).delete
  end

  def delete_all
    table.delete
  end

  def locate_robot(id)
    table.where(id: id)
  end

  def birthday_strings
    table.to_a.map {|robot| robot[:birthdate]}
    # database.transaction do
    #   birthday_strings = database["robots"].map { |robot| robot["birthdate"]}
    # end
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
