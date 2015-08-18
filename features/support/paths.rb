module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /^that ([\w ]+)'s page$/
      polymorphic_path(instance_variable_get("@#{$1.parameterize('_')}"))
    else
      match_rails_path_for(page_name)
    end
  end

  def match_rails_path_for(page_name)
    if page_name.match(/the (.*) page/)
      return send "#{$1.gsub(" ", "_")}_path" rescue nil
    end
  end
end

World(NavigationHelpers)

