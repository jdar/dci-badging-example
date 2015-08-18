module CodeAmbush
if Rails.env.development? && File.basename($0) != 'rake'
class Railtie < Rails::Railtie
  config.after_initialize do
    schools = School.take(2)
    if schools[0].nil?
      STDOUT.puts <<-EOF
        Thanks for installing. If you want to try out the demo, 
        run this command `rake db:import:demo` and THEN use these credentials:
        site: 
          username: e.hoover@foo.com
          password: password
        /admin
          username: admin@example.com 
          password: password
      EOF
    elsif schools[1].nil?
      STDOUT.puts <<-EOF
        Example credentials:

        site: 
          username: e.hoover@foo.com
          password: password
        /admin
          username: admin@example.com 
          password: password
      EOF
    end
  end
end
end
end
