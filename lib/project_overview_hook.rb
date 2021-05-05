class PjpWeeklyReportLayoutHook < Redmine::Hook::ViewListener
  render_on :view_projects_show_right, :partial => "redmine_activity_monitor/index"
end