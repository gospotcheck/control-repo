class profile::disk_manager {
  mounted_disk { 'backups':
    disk_id   => 'google-dba-backups',
    disk_name => 'backups',
    disk_size => '1500GB'
  }
}
