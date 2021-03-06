# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

get "/" do
  erb :home
end



class Contact < ActiveRecord::Base
  self.table_name = 'salesforce.contact'
end

class JobNumber < ActiveRecord::Base
  self.table_name = 'salesforce.job_number__c'
end

get "/contacts" do
 @contacts = Contact.all
 erb :index
end

get "/job-numbers" do
  @jobnumbers = JobNumber.all
  erb :job_index
end

get "/job-numbers/new" do
  @jobnumber = JobNumber.new
  erb :job_new
end

post "/job-numbers" do
  @jobnumber = JobNumber.new(params[:job_number])
  @jobnumber.save
  redirect to("/job-numbers")
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
