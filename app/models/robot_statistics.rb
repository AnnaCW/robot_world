class RobotStatistics
  attr_reader :table

  def initialize(table)
    @table = table
  end

  def birthdates
    table.to_a.map {|robot| robot[:birthdate]}
  end

  def birthdates_split
     birthdates.map {|date| date.split("-")}
  end

  def average_age
    years = birthdates_split.map {|date| Time.mktime(date[0].to_i)}
    ages = years.map {|year| Time.now - year}
    (ages.reduce(:+)/ages.length/31536000).round
  end

  def hire_dates
    table.to_a.map {|robot| robot[:date_hired]}
  end

  def hire_dates_split
    hire_dates.map {|date| date.split("-")}
  end

  def robots_hired_per_year
    years = hire_dates_split.map {|date| date[0]}.map
    year_occurences = years.group_by {|year| year}
    year_occurences.map {|year, occurences| [year, occurences.count]}
  end

  def robot_cities
    table.to_a.map { |robot| robot[:city]}
  end

  def robots_per_city
    city_occurences = robot_cities.group_by {|city| city}
    city_occurences.map {|city, occurences| [city, occurences.count]}
  end

  def robot_states
    table.to_a.map { |robot| robot[:state]}
  end

  def robots_per_state
    state_occurences = robot_states.group_by {|state| state}
    state_occurences.map {|state, occurences| [state, occurences.count]}
  end

  def robot_departments
    table.to_a.map {|robot| robot[:department]}
  end

  def robots_per_department
    departments = robot_departments.group_by {|department| department}
    departments.map {|department, occurences| [department, occurences.count]}
  end

end
