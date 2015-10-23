# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

get "/" do
  erb :home
end



class Contact < ActiveRecord::Base
  self.table_name = 'salesforce.Contact'
end

class JobNumber < ActiveRecord::Base
  self.table_name = 'salesforce.Job_Number__c'
end

get "/contacts" do
 @contacts = Contact.all
 erb :index
end

get "/job-numbers" do
  @jobnumbers = JobNumber.all
  erb :jobs_index
end

get "/create" do
  CREATE_URL = 'https://connect.heroku.com/dashboard-next/create-connection'
  match = /(.*?)\.herokuapp\.com/.match(request.host)
  if match && match[1]
    redirect to(CREATE_URL + "?create=" + match[1])
  else
    redirect to(CREATE_URL)
  end
end
