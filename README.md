# DbCacheStore

Alternative rails cache engine, that will use database with `activerecord`

![What!?](https://media.giphy.com/media/3mJMxWRhmeiGukabki/giphy.gif)

## Install

Add this line to your application's Gemfile:

```ruby
gem 'db-cache-store'
```

## Usage

### Global Usage

It's __NOT__ recommened to use it as global application cache because it's slow.

Supported rails versions: '>= 5.0', '< 5.2'

First you need to genereate table:

```ruby
DbCacheStore:
  db_cache_store:migration [TABLE_NAME=db_cache_store_items]
```

Then declare your cache model and update configuration in application.rb:

```ruby
class MyCacheRepository < ActiveSupport::Cache::DbItem
  self.table_name = :cache_items
end
```

```ruby
config.cache_store = :db_cache_store, repository: MyCacheRepository
```

### Local usage

```ruby
cache_store = ActiveSupport::Cache.lookup_store(:db_store, repository: MyCacheRepository)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

`rake` will run unit tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/caulfield/db-cache-store
