# encoding: utf-8
require "date"
module RedmineActivityMonitor
  def target_label
    labels = nil
    (0..6).each{|i| labels = "'#{((Date.today)-i).strftime("%Y-%m-%d")}',#{labels}"}
    return labels.chop
  end

  def new_issue_count(project_id, target)
    result = []
    dates = target.gsub(/'/,'').split(',')
    dates.each do |date|
      result << Issue.where(project_id: project_id).where('created_on like ?', "#{date}%").count
    end
    return result
  end

  def closed_issue_count(project_id, target)
    result = []
    dates = target.gsub(/'/,'').split(',')
    closed_status_ids = IssueStatus.where(is_closed: 1).pluck(:id)
    dates.each do |date|
      result << Issue.where(project_id: project_id, status_id: closed_status_ids).where('updated_on like ?', "#{date}%").count
    end
    return result
  end

  def get_processed_max_value(new_max_count, closed_max_count)
    max_count = new_max_count > closed_max_count ? new_max_count : closed_max_count

    # Calculate max_value to devide a graph into 5 gridline in the vertical direction
    max_count = 5 if max_count == 0
    margin = max_count % 5 == 0 ? 0 : 1
    max_value = (max_count / 5 + margin) * 5
    step = max_value / 5
    return max_value, step
  end

  module_function :target_label, :new_issue_count, :closed_issue_count, :get_processed_max_value
end