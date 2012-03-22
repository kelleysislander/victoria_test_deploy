=begin
NOTE: This is run from the local: "cap beaglebone deploy" after first ssh'ing to beaglebonedev: 

ssh deploy@69.26.213.218 -p 922 -L 1922:10.0.1.160:22

Once you do this then in another terminal window you can "ssh root@10.0.1.160" to work on the beaglebone or deploy.
You must first "ssh deploy@69.26.213.218 -p 922 -L 1922:10.0.1.160:22" before capistrano will be able to use
"10.0.1.160" as the domain
=end
#############################################################
#	Application
#############################################################

set :application, 'victoria_test_deploy'
set :app_uri,   'victoria_test_deploy.semaphoremobile.com'
set :deploy_to, "/var/www/vhosts/#{app_uri}"
set :gem_home, '/home/root/.rvm/gems/ruby-1.9.2-p290@victoria_test_deploy'
set :gem_path, '/home/root/.rvm/gems/ruby-1.9.2-p290:/home/deploy/.rvm/gems/ruby-1.9.2-p290@global' # got these last 2 via "gem info" on the app server's app root

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :chmod755, "app config db lib public vendor script script/* public/*"
set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :scm_verbose, true
set :padrino_env, "beaglebone"
set :bundle_flags, "--deployment"
set :rvm_shell, '/home/root/.rvm/bin/rvm-shell'

#############################################################
#	Servers
#############################################################

set :user, "root" 
set :db_user, "root"
set :domain, "10.0.1.160"
set :port, 22
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	git
#############################################################

set :scm, :git
set :repository, "git@github.com:kelleysislander/victoria_test_deploy.git"
set :branch, "master"
#set :repository_cache, "git_cache"
#set :deploy_via, :remote_cache         # http://help.github.com/capistrano/ says: In most cases you want to use this option, otherwise each deploy will do a full repository clone every time.
#set :deploy_via, :checkout
#set :checkout, "export"
#set :scm_user, user


=begin

http://help.github.com/capistrano/ says:

Known Hosts bug

If you are not using agent forwarding, the first time you deploy may fail due to Capistrano not prompting with this message:

The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)?

To fix this, ssh into your server as the user you will deploy with, run ssh git@github.com and confirm the prompt.

=end