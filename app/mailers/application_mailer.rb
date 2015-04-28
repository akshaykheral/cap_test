# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default from: "akshay@readersdoor.com"
  layout 'mailer'
end
 
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
end