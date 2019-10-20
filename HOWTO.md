# How To Parking API  in ruby on Rails

## 1) Create Project Structure
``` bash
$ rails new mlabs-parking --api -T
```

> [!TIP]
> To use postgre database add flag --database=postgresql


## 2) Add Gem's for Testing, fixtures, more matchers and generate fake data.
- put in the file "mlabs-parking/Gemfile"
```Gemfile
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end
```

## 3) Install the gem's
``` bash
$ bundle install
```

## 4) Initialize the spec directory 
``` bash
$ rails generate rspec:install
```

## 5) Create a factories directory
``` bash
$ mkdir spec/factories
```

## 6) Configuration In spec/rails_helper.rb
- update the file "spec/rails_helper.rb" with informations
``` ruby
# require database cleaner at the top level
require 'database_cleaner'

# ...
# configure shoulda matchers to use rspec as the test framework and full matcher libraries for rails
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# ...
RSpec.configure do |config|
  # ...
  # add `FactoryBot` methods
  config.include FactoryBot::Syntax::Methods

  # start by truncating all the tables but then use the faster transaction strategy the rest of the time.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  # ...
end
```


## 7) Create the Model Parking:
    $ rails g model Parking plate:string car_in:datetime car_out:datetime paid:boolean
    
## 8) Initialize database
    $ rails db:migrate

## 9) Set model test in file "./mlabs-parking/spec/models/parking_spec.rb"
``` ruby
require 'rails_helper'

RSpec.describe Parking, type: :model do
    it { should validate_presence_of(:plate) }
    it { should allow_value("XYZ-1234").for(:plate) }
    it { should_not allow_value("New York").for(:plate) } 
end
```

## 10) See test fail!!!

``` bash
  $ rails db:environment:set RAILS_ENV=development
  $ bundle exec rspec
```
    
## 11) Set validations in "./mlabs-parking/app/models/parking.rb"
``` ruby
class Parking < ApplicationRecord
    # validations
    validates_presence_of :plate
    validates :plate, length: { minimum: 8 }
    validates :plate, format: { with: /\A[A-Z]{3}-[0-9]{4}\z/,
        message: "format is AAA-9999" }
end
```

## 12) Run test and see pass!
``` bash
rake db:drop RAILS_ENV=development
rake db:drop RAILS_ENV=test
rake db:migrate RAILS_ENV=development
rails db:environment:set RAILS_ENV=development
bundle exec rspec

```


## 13) Create controller structure
``` bash
$ rails g controller Parking
```

## 14) Create structure for specifications of request API
``` bash
$ mkdir spec/requests && touch spec/requests/parking_spec.rb
```

## 15) Create the factories
``` bash
$ touch spec/factories/parkings.rb
```
Information the user should notice even if skimming put in file "spec/factories/parkings.rb"

``` ruby
FactoryBot.define do
  factory :parking do
    plate { "AAA-9876" }
    car_in { "2019-10-19 13:34:23" }
    car_out { nill }
    paid { false }
  end
end
```

## 16) Create spec of API

- put in the file "spec/requests/parking_spec.rb"
  
``` ruby
require 'rails_helper'

RSpec.describe 'Parking API', type: :request do
  # initialize test data 
  let!(:parking) { create_list(:parking, 10) }
  let(:parking_id) { parking.first.id }

  # Test suite for GET /parking
  describe 'GET /parking' do
    # make HTTP get request before each example
    before { get '/parking' }
    it 'returns parking car\'s' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

  end
  ...
end
```

## 17) Custom helper method json which parses the JSON response to a ruby Hash

- make directorie and create file

``` bash
$ mkdir spec/support && touch spec/support/request_spec_helper.rb
```

- put in "spec/support/request_spec_helper.rb"

``` ruby
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
```

## 18) Enable support directory autoloaded

- change file "spec/rails_helper.rb" with:

``` ruby
# ...
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# ...
RSpec.configuration do |config|
  # ...
  config.include RequestSpecHelper, type: :request
  # ...
end
```

## 19) Run Test

- See test's broken!!!

``` bash
$ bundle exec rspec
```

## 20) Configing the routes

- put in "config/routes.rb"

``` ruby
Rails.application.routes.draw do
  resources :todos do
    resources :items
  end
end
```

- Create default routes

``` bash
$ rails routes
```

# 21) Allow any hosts for development

- put in the file "config/environments/development.rb"

``` ruby
config.hosts = nil
```
