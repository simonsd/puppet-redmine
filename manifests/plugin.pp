define redmine::plugin (
  $url,
  $plugin_dir = "${redmine::home}/vendor/plugins",
  $deps       = [],
  $gems       = []
) {
  exec {
    "install_plugin_${name}":
      command => "ruby script/plugin install ${url}",
      cwd     => $redmine::home,
      creates => "${plugin_dir}/${name}";
  }

  @package {
    $deps:
      ensure => present,
      before => Exec["install_plugin_${name}"];
    $gems:
      ensure   => present,
      provider => gem,
      before   => Exec["install_plugin_${name}"];
  }

  if $deps != [] {
    realize(Package[$deps])
  }

  if $gems != [] {
    realize(Package[$gems])
  }
}
