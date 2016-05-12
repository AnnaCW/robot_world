
class RobotWorldApp < Sinatra::Base

  get '/' do
    # @robot_statistics = RobotStatistics.new
    erb :dashboard
  end
# define instance varible here equal to the class where the code occurs

  get '/robots' do
    @robots = robot_repository.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_repository.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_repository.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_repository.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_repository.update(id.to_i, params[:robot])
    redirect "/robots"
  end

  delete '/robots/:id' do |id|
    robot_repository.destroy(id.to_i)
    redirect "/robots"
  end

  def average_age
    robot_repository.average_age
  end

  def robots_per_city
    robot_repository.robots_per_city
  end

  def robots_per_state
    robot_repository.robots_per_state
  end

  def robots_per_department
    robot_repository.robots_per_department
  end


  def robot_repository
    if ENV['RACK_ENV'] == "test"
      database = Sequel.postgres('robot_repository_test')
    else
      database = Sequel.postgres('robot_repository')
    end
    @robot_repository ||= RobotRepository.new(database)
  end

end
