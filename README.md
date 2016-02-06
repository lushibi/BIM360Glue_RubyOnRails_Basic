# BIM360Glue_RubyOnRails_Basic
Ruby on Rails example on how to use web services of Autodesk BIM 360 Glue to login.

## Steps:

Step1: Install and try
* Install Ruby and Rails from http://railsinstaller.org
* Run `rails -v` to check rails installed successfully
* Run `rails new BIM360Glue_RubyOnRails_Basic` to create a new rails app
* Run `cd <YourCodeDirectory> && bundle install`, note: this step may be executed automatically by the previous command
* Run `rails server`
* Browser to "http://localhost:3000/"

Step2: Change default home page
* Add home page: run `rails generate controller welcome index`, see [Ruby on rails getting started](http://guides.rubyonrails.org/getting_started.html), It will generate several files, followings are the most important ones
  * app/views/welcome/index.html.erb - the html page template
  * app/controllers/welcome_controller.rb - the controller
  * app/assets/javascripts/welcome.js.coffee - javascript written in [coffeescript](http://coffeescript.org/), which will be compiled into application.js
  * app/assets/stylesheets/welcome.css.scss - css written in [sass](http://sass-lang.com/), which will be compiled into application.css
* Open the file `config/routes.rb` in your editor, uncomment this line `# root 'welcome#index'`
* Run `rails server` and browser to `http://localhost:3000` again, you will see the home page changed to what you just created

Step3: Add functions to login to Glue
* Copy `helpers/application_helper.rb` from this github to your local folder, and modify credential information `CREDENTIALS_API_KEY`, `CREDENTIALS_API_SECRET`, `CREDENTIALS_COMPANY_ID` with your own api_key, api_secret and company_id, this file also defines login url and a function named `glue_login` which is used to login to Glue
* Open `controllers/application_controller.rb`, add `include ApplicationHelper` before `end`, this allows all variables and functions are available in ApplicationController and its derived classes
* Copy `views/welcome/index.html.erb` from this github to your local folder
* Run `rails generate controller Sessions new`
* Open `router.rb`, add following code under `get 'welcome/index'`, it defines login and logout routes

      ````
      get    'login'   => 'sessions#new'
      post   'login'   => 'sessions#create'
      delete 'logout'  => 'sessions#destroy'
      ````
* Copy `controllers/sessions_controller.rb` and `helpers/sessions_helper.rb`
* Include SessionsHelper in ApplicationControllers by adding `include SessionsHelper` in file `controllers/application_controller.rb`
* Add error prompt for login, so that we know what's wrong if login failed, add following code in `application.html.erb` and `application.css`
      ````
      <div>
        <% flash.each do |message_type, message| %>
          <div class="alert alert-<%= message_type %>"><%= message %></div>
        <% end %>
      </div>
      ````

      ````
      .alert.alert-danger {
        color: red;
      }
      ````
Step4: Run `rails server`
