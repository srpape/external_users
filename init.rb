require_dependency 'user_patch'
require_dependency 'project_patch'

Redmine::Plugin.register :external_users do
  name 'External Users plugin'
  author 'Stephen Pape'
  description 'Prevent users marked as external from seeing any projects for which they are not a member of'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
