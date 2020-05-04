define mounted_disk (
  $disk_id = '',
  $disk_name = '',
  $disk_size = ''
){
  physical_volume { "/dev/disk/by-id/${disk_id}":
    ensure => present,
  }

  volume_group { $disk_id:
    ensure           => present,
    physical_volumes => "/dev/disk/by-id/${disk_id}",
  }

  logical_volume { $disk_id:
    ensure       => present,
    volume_group => $disk_name,
    size         => $disk_size,
  }

  filesystem { "/dev/disk/by-id/${disk_id}":
    ensure  => present,
    fs_type => 'ext4',
    options => '-m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard',
  }

  mount {"/mnt/disk/${disk_name}":
    ensure => 'mounted',
    device => "/dev/disks/by-id/${disk_id}",
    fstype => 'ext4',
  }
}
