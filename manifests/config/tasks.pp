# Define: nexus3::config::tasks
#
# Example in hiera:
#  nexus3::config::tasks:
#    'task1':
#      task_name: 'task1'
#      type: 'script'
#      frequency: 'daily'
#      start_date: '2020-12-01'
#      start_time: '20:00'

define nexus3::config::tasks (
  $task_name       = $title,
  $enabled         = 'true',
  $type            = undef,
  $alert_email     = undef,
  $frequency       = undef,
  $start_date      = undef,
  $start_time      = undef,
  $cron_expression = undef,
  $recurring_day   = undef,
){

  nexus3_task { $task_name:
    enabled         => $enabled,
    type            => $type,
    alert_email     => $alert_email,
    frequency       => $frequency,
    start_date      => $start_date,
    start_time      => $start_time,
    cron_expression => $cron_expression,
    recurring_day   => $recurring_day,
  }
}

