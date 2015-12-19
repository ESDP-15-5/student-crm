json.array!(@periods) do |period|
  json.extract! period, :id, :title, :course_element_id
  json.start period.commence_datetime
  json.url course_period_url(params[:course_id], period, format: :html)
end