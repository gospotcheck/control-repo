# Formats and mounts a disk by id and size
# and mounts with with the given name.
define mounted_disk (
  $disk_id = '',
  $disk_name = '',
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
    volume_group => $disk_id,
  }

  filesystem { "/dev/disk/by-id/${disk_id}":
    ensure  => present,
    fs_type => 'ext4',
    options => '-m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard',
  }

  mount {"/mnt/${disk_name}":
    ensure => 'mounted',
    device => "/dev/disk/by-id/${disk_id}",
    fstype => 'ext4',
  }
}
