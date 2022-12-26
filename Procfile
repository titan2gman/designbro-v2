# Run Rails & Webpack concurrently
# Example file from webpack-rails gem
web: bin/rails server -p $PORT -e $RAILS_ENV
# rails: bundle exec rails server -p 3000
webpack: ./node_modules/.bin/webpack-dev-server --config config/webpack.config.js
worker: bundle exec sidekiq -C config/sidekiq.yml
clock: bundle exec clockwork clock.rb