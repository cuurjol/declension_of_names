class PeopleController < ApplicationController
  def index
    @people = Person.includes(:declension_name)
  end

  def show
    @person = find_person
  end

  def new
    @person = Person.new
  end

  def edit
    @person = find_person
  end

  def create
    @person = Person.new(person_params)
    @person.full_name = CreateFullNameService.call(person_params.except(:sex))

    if @person.save
      DeclensionNameService.call(@person)
      redirect_to(@person, flash: { success: 'Человек был успешно создан.' })
    else
      render(:new)
    end
  end

  def update
    @person = find_person
    @person.full_name = CreateFullNameService.call(person_params.except(:sex))

    if @person.update(person_params)
      DeclensionNameService.call(@person)
      redirect_to(@person, flash: { success: 'Данные о человеке былы успешно обновлены.' })
    else
      render(:edit)
    end
  end

  def destroy
    find_person.destroy
    redirect_to(people_url, flash: { success: 'Человек был успешно удалён.' })
  end

  private

  def find_person
    Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :middle_name, :sex)
  end
end
