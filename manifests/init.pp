class redmine (
  $production_db = 'redmine_production',
  $devel_db = 'redmine_devel',
  $dbuser = 'redmine',
  $dbpass = 'redmine',
  $dbhost = 'localhost',
  $dbserver = 'localhost',
  $home = '/usr/share/redmine',
  $plugins = [],
  $mail_user = 'redmine',
  $mail_pass = 'redmine',
  $mail_auth = 'plain',
  $mail_domain = 'redmine.org',
  $mail_port = '587',
  $mail_smtp = 'smtp.redmine.org',
  $mail_tls = true,
  $themes = [],
  $webserver_service = 'httpd',
  $version = 'latest',
  $user    = 'apache',
  $group   = 'apache',
) {
  if ! defined(Class['::repos']) { include ::repos }

  class {'::redmine::depends': } ->
  class {'::redmine::config': } ->
  class {'::redmine::dbconf': } ->
  class {'::redmine::plugins': } ->
  class {'::redmine::themes': }

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  }

}
