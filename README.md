# BIM360Glue_RubyOnRails_Basic
Ruby on Rails example on how to use web services of Autodesk BIM 360 Glue to login, query project informaiton and embed its display component (to view 3d model) into your web page.

## Steps:

Step1: install and try
* Install Ruby and Rails from http://railsinstaller.org
* `rails -v` to check rails installed successfully
* `rails new BIM360Glue_RubyOnRails_Basic` to create a new rails app
* `cd <YourCodeDirectory> && bundle install`: this step may be executed automatically by the last command
* `rails server`
* Browser to "http://localhost:3000/"

Step2: change default home page
* Add home page, run `rails generate controller welcome index`, see [Ruby on rails getting started](http://guides.rubyonrails.org/getting_started.html), It will generate several files, followings are the most important once
** app/views/welcome/index.html.erb - the html page template
** app/controllers/welcome_controller.rb - the controller
** app/assets/javascripts/welcome.js.coffee - javascript written in [coffeescript](http://coffeescript.org/), which will be compiled into application.js
** app/assets/stylesheets/welcome.css.scss - css written in [sass](http://sass-lang.com/), which will be compiled into application.css
* Open the file config/routes.rb in your editor, add `root 'welcome#index'` or uncomment this line `# root 'welcome#index'`
* Run `rails server` and browser to "http://localhost:3000/" again, you will see the home page changed to what you just created

Step3: add functions to login to Glue
* Copy `helpers/application_helper.rb` from this github to your local folder, and modify credential information with your own api_key, api_secret and company_id, you can see it also defines login url and a function named glue_login which is used to login to Glue
* Open `controllers/application_controller.rb`, add this line `include ApplicationHelper` before `end`, this all variables and functions are available for ApplicationController and its derived classes
* Copy `views/welcome/index.html.erb` from this github to your local folder
* run `rails generate controller Sessions new`
* Open `router.rb` and add following code under `get 'welcome/index'`, it defines login and logout routes
      ````
        get    'login'   => 'sessions#new'
        post   'login'   => 'sessions#create'
        delete 'logout'  => 'sessions#destroy'
      ````
* Copy `controllers/sessions_controller.rb` and `helpers/sessions_helper.rb`
* include SessionsHelper in ApplicationControllers by adding `include SessionsHelper` in file `controllers/application_controller.rb`
* add error information for login in application.html.erb, also css in application.css
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

Step4: run `rails server`
