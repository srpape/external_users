External Users Plugin for Redmine
=================================

External users are not able to see public projects. They can only see a project if they are a member.

Installation 
------------

0. Follow the Redmine plugin installation steps at: [http://www.redmine.org/wiki/redmine/Plugins](http://www.redmine.org/wiki/redmine/Plugins)
1. Cd to your redmine `plugins/` dir
2. Git-clone the plugin from this repo into a folder in there: `git clone https://github.com/srpape/external_users.git external_users`
3. Run the plugin migrations `rake redmine:plugins:migrate RAILS_ENV=production`
4. Restart your Redmine web servers (e.g. mongrel, thin, mod_rails)
5. Login to your Redmine install as an Administrator
6. Edit the profile of the user(s) you wish to mark as external.

