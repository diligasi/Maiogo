source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Assets gems group
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# gem 'materialize-sass'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Facebook integration
gem 'omniauth'
gem 'omniauth-facebook', '1.4.0'

group :development do
  gem 'thin'
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'

  platforms :ruby do # linux
    gem 'unicorn'
  end

  # Use postgresql as the database for Active Record
  gem 'pg'
end
