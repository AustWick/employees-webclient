class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees.json").body
  end

  def new
    
  end

  def create
    @employee = Unirest.post(
                             "#{ ENV['HOST_NAME'] }/api/v2/employees",
                             headers: { "Accept" => "application/json" }, 
                             parameters:{
                                          first_name: params[:first_name],
                                          last_name: params[:last_name],
                                          email: params[:email]
                                         }
                            ).body

    redirect_to "/employees/#{@employee['id']}"
  end

  def show
    @employee = Employee.new(Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json").body)
  end

  def edit
    @employee = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json").body
  end

  def update
    @employee = Unirest.patch(
                              "#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}",
                              headers: { "Accept" => "application/json" },
                              parameters: {
                                            first_name: params[:first_name],
                                            last_name: params[:last_name],
                                            email: params[:email]
                                          }
                              ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    response = Unirest.delete(
                              "#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}",
                              headers: { "Accept" => "application/json"}
                              )
    redirect_to '/'
  end
end










