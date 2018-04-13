lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "db_cache_store/version"

Gem::Specification.new do |spec|
  spec.name          = "db-cache-store"
  spec.version       = DbCacheStore::VERSION
  spec.authors       = ["Sergey Kuchmistov"]
  spec.email         = ["sergey.kuchmistov@gmail.com"]

  spec.summary       = "Alternative rails cache engine, that will use database server"
  spec.description   = "Alternative rails cache engine, that will use database server"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 5.0', '< 5.2'
 
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '>= 5.0.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry'
end
