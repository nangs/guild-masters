# guild-masters
A Web-based guild strategy simulation game.

You can access the website at nus school of computing: [https://172.25.79.43:3000/](http://172.25.79.43:3000/)


## Setting Up For developers:
* Install [ruby](https://www.ruby-lang.org/en/downloads/) and [rails](http://rubyonrails.org/download/).		
    		
* Download the gems		
    ```bash		
    $ bundle		
    ```		
		
* Setup the database:	
    ```bash		
    $ rake db:setup		
    ```		
		
* Run the server in development mode
    ```		
    $ bundle exec rails server
    ```		
* You can access the website at: [https://localhost:3000/](https://localhost:3000/)

* For production mode:
    ** setup the databse:
    ```     
    $ db:migrate RAILS_ENV="production"
    ```
    ** run the server:
    $ bundle exec rails server -e production
    ``` 