module PeopleHelper
  def person_actions(customer)
    <<-HTML.html_safe
      #{link_to('Показать', person_path(customer))}
       |
      #{link_to('Редактировать', edit_person_path(customer))}
       |
      #{link_to('Удалить', person_path(customer), method: :delete, data: { confirm: 'Вы уверены, что хотите удалить человека?' })}
    HTML
  end

  def people_list(people)
    return content_tag(:p, 'Людей не найдено') if people.blank?

    render(partial: 'people/table', locals: { people: people })
  end

  def declension_type(name_case)
    case name_case
    when :genitive then 'Родительный'
    when :dative then 'Дательный'
    when :accusative then 'Винительный'
    when :instrumental then 'Творительный'
    else 'Предложный'
    end
  end
end
