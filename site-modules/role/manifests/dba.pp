class role::dba {

  #This role would be made of all the profiles that need to be included to make a database management server work
  #All roles should include the base profile
  # include profile::base
  include profile::disk_manager
  # include profile::db_maintenance
  # include profile::db_backup_manager

}
