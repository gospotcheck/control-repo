class profile::disk_manager {
  mounted_disk { 'backups':
    disk_id   => 'google-backups',
    disk_name => 'backups',
  }
}
