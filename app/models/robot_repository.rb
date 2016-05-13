class RobotRepository
  attr_reader :database
  attr_reader :table
  attr_reader :statistics

  def initialize(database)
    @database = database
    @statistics = RobotStatistics.new(table)
  end

  def create(robot)
    table.insert(name: robot[:name], city: robot[:city], state: robot[:state], avatar: robot[:avatar], birthdate: robot[:birthdate], date_hired: robot[:date_hired], department: robot[:department])
  end

  def table
    @table = database.from(:robots).order(:id)
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

  # def birthdates
  #   table.to_a.map {|robot| robot[:birthdate]}
  # end
  #
  # def birthdates_split
  #    birthdates.map {|date| date.split("/")}
  # end
  #
  # def average_age
  #   years = birthdates_split.map {|date| Time.mktime(date[2].to_i)}
  #   ages = years.map {|year| Time.now - year}
  #   (ages.reduce(:+)/ages.length/31536000).round
  # end
  #
  # def robot_cities
  #   table.to_a.map { |robot| robot[:city]}
  # end
  #
  # def robots_per_city
  #   city_occurences = robot_cities.group_by {|city| city}
  #   city_occurences.map {|city, occurences| [city, occurences.count]}
  # end
  #
  # def robot_states
  #   table.to_a.map { |robot| robot[:state]}
  # end
  #
  # def robots_per_state
  #   state_occurences = robot_states.group_by {|state| state}
  #   state_occurences.map {|state, occurences| [state, occurences.count]}
  # end
  #
  # def robot_departments
  #   table.to_a.map {|robot| robot[:department]}
  # end
  #
  # def robots_per_department
  #   departments = robot_departments.group_by {|department| department}
  #   departments.map {|department, occurences| [department, occurences.count]}
  # end

end
