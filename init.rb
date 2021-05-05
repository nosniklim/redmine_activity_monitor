require_dependency 'project_overview_hook.rb'
require_dependency 'redmine_activity_monitor.rb'

Redmine::Plugin.register :redmine_activity_monitor do
  name 'Redmine Activity Monitor'
  author 'nosniklim'
  description 'This plugin is designed to assist monitoring latest activities on Redmine'
  version '0.0.1'
end
