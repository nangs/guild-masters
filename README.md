# guild-masters
A Web-based guild strategy simulation game.

## Setting Up
* Install [ruby](https://www.ruby-lang.org/en/downloads/) and [rails](http://rubyonrails.org/download/).

* Move to the directory for the server
    ```bash
    $ cd guildmasters
    ```
    
* Download the gems
    ```bash
    $ bundle
    ```

* Do the migration in the `lib` folder
    ```bash
    $ rake db:migrate
    ```

* Run the server
    ```
    $ Rails server
    ```
    or 
    ```
    $ rails server
    ```
    
* You can access the website at: [http://localhost:3000/](http://localhost:3000/)
