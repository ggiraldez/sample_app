namespace :app do
  desc <<-DESC
    Load demo data.
    Run using the command 'rake add:load_demo_data'
  DESC
  task :load_demo_data => [:environment] do
    User.delete_all
    User.create!(:name => "Example User", :email => "user@example.com",
                 :password => "foobar", :password_confirmation => "foobar")
    User.create!(:name => "John Doe", :email => "johndoe@gmail.com",
                 :password => "anyone", :password_confirmation => "anyone")

  end
end

