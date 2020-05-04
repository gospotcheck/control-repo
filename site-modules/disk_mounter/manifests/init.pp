define mounted_disk (
  $disk_id = '',
  $disk_name = '',
  $disk_size = ''
){
  lvm::volume { $disk_id:
    ensure  => present,
    vg      => $disk_id,
    pv      => "/dev/disk/by-id/${disk_id}",
    fstype  => 'ext4',
    size    => $disk_size,
    options => '-m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard'
  }

  mount {"/mnt/disks/${disk_name}":
    ensure  => 'mounted',
    device  => "/dev/disks/by-id/${disk_id}",
    fstype  => 'ext4',
    require => Lvm::Volume[$disk_name]
  }
}
