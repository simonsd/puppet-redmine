class redmine::dbconf {
  exec { 'config_redmine_mysql_bootstrap':
    environment => 'RAILS_ENV=production',
    path        => $ruby::bin_dir,
    cwd         => $redmine::home,
    provider    => 'shell',
    command     => 'rake db:migrate',
    refreshonly => true,
    notify      => [
      Service[$redmine::webserver_service],
      Exec['load_default_data'],
    ]
  }
  exec {'load_default_data':
    environment => ['RAILS_ENV=production', 'REDMINE_LANG=en'],
    path        => $ruby::bin_dir,
    cwd         => $redmine::home,
    provider    => 'shell',
    refreshonly => true,
    command     => 'rake redmine:load_default_data',
    require     => [ Exec['config_redmine_mysql_bootstrap'] ],
    notify      => Service[$redmine::webserver_service];
  }
}
