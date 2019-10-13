class CreateFullNameService < ApplicationService
  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @middle_name = params[:middle_name]
  end

  def call
    [@last_name, @first_name, @middle_name].join(' ')
  end
end
