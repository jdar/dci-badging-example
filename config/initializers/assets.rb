Rails.application.config.assets.paths << "#{Rails.root}/app/assets/schools/shared/badges"
Dir.glob("#{Rails.root}/app/assets/schools/**/badges").each do |path|
  Rails.application.config.assets.paths << path
end
