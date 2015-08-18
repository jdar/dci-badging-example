namespace :db do
  namespace :import do 
    task :school => :environment do
      load (Rails.root+"script/add_new_school").to_s
    end

    task :demo => :environment do
      ENV['SCHOOL_DIR']='input/chucknorris'
      School.transaction do 
        #remove existing data 
        School.where(param: 'chucknorris').first.destroy rescue nil
        #refresh
        load (Rails.root+"script/add_new_school").to_s
      end
    end
  end

  task :import => ["import:school"]
end