# require 'capistrano_colors'    
# 
# capistrano_color_matchers = [
#   { :match => /command finished/,       :color => :hide,      :prio => 10 },
#   { :match => /executing command/,      :color => :blue,      :prio => 10, :attribute => :underscore },
#   { :match => /^transaction: commit$/,  :color => :magenta,   :prio => 10, :attribute => :blink },
#   { :match => /git/,                    :color => :white,     :prio => 20, :attribute => :reverse },
# ]
# 
# colorize( capistrano_color_matchers )
# 
# 
# # config/deploy.rb
# # We're using RVM on a server, need this.
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# set :rvm_ruby_string, '1.9.3@pope --create'
# set :rvm_type, :user
# 
# # Bundler tasks
# require 'bundler/capistrano'
# 
# set :application, "pope"
# set :repository,  "git@github.com:pupca/pope_election.git"
# 
# set :scm, :git
# 
# # do not use sudo
# set :use_sudo, false
# set(:run_method) { use_sudo ? :sudo : :run }
# 
# # This is needed to correctly handle sudo password prompt
# default_run_options[:pty] = true
# 
# set :user, "root"
# set :group, user
# set :runner, user
# 
# set :host, "#{user}@pope.labs.polarion.com" # We need to be able to SSH to that box as this user.
# role :web, host
# role :app, host
# 
# set :rails_env, :production
# 
# # Where will it be located on a server?
# set :deploy_to, "/var/www/#{application}"
# set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
# set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
# 
# # Unicorn control tasks
# namespace :deploy do
#   task :restart do
#     run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
#   end
#   task :start do
#     run "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
#   end
#   task :stop do
#     run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
#   end
# end



require 'capistrano_colors'    

capistrano_color_matchers = [
  { :match => /command finished/,       :color => :hide,      :prio => 10 },
  { :match => /executing command/,      :color => :blue,      :prio => 10, :attribute => :underscore },
  { :match => /^transaction: commit$/,  :color => :magenta,   :prio => 10, :attribute => :blink },
  { :match => /git/,                    :color => :white,     :prio => 20, :attribute => :reverse },
]

colorize( capistrano_color_matchers )

# set :whenever_environment, "production"
# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"
set :application, "pope"

set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
set :scm, :git
set :repository, "git@github.com:pupca/pope_election.git"
set :user,        "root"
set :keep_releases, 5

set :rvm_ruby_string, "1.9.3@pope"
set :rvm_type, :system
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :unicorn_env, "production"
set :app_env, "production"

server "pope.labs.polarion.com", :app, :web, :db, :primary => true

before 'deploy:setup',   'rvm:install_rvm'
before 'deploy:setup',   'rvm:install_ruby'
after  'deploy',         'deploy:cleanup'
after  'deploy:update_code', 'deploy:symlink_shared'


namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/pope.db #{release_path}/pope.db"
  end
end

require "rvm/capistrano"
require "bundler/capistrano"
require "capistrano-unicorn"


