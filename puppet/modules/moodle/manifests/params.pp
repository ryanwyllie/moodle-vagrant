class moodle::params {
  $ensure = "present"
  $directory_ensure = "directory"
  $package_ensure = "present"
  $user = "vagrant"
  $user_home_dir = "/home/${user}"
}
