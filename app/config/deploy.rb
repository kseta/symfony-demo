# Application
set :application,   "SymfonyDemoAppForCI"
set :domain,        "symfony-demo-staging"
set :app_path,      "app"
set :model_manager, "doctrine"

# Application Reposiroty
set :repository, "git@github.com:kseta/SymfonyDemoAppForCI.git"
set :scm,        :git

# Deploy role
role :web, domain
role :app, domain, :primary => true

# Deploy User
set :user, "vagrant"

# Deploy Server
set :deploy_to,  "/var/www/symfony-demo.com"
set :deploy_via, :copy
set :use_sudo,   false

# Assetic
set :dump_assetic_assets, true

# Shared
set :shared_files,    ["composer.phar", "app/config/parameters.yml"]
set :shared_children, [app_path + "/logs", web_path + "/uploads", "vendor"]

# Dependencies
set :use_composer,   true
set :update_vendors, false

# Ignore
set :copy_exclude, [".git/*", ".gitignore"]

# Be more verbose by uncommenting the following line
# logger.level = Logger::MAX_LEVEL
