define mounted_disk (
  $disk_id = '',
  $disk_name = '',
  $disk_size = ''
){
  lvm::physical_volume { "/dev/disks/by-id/${disk_id}":
    ensure => present,
  }

  lvm::volume_group { "/dev/disks/by-id/${disk_id}":
    ensure           => present,
    physical_volumes => "/dev/disks/by-id/${disk_id}",
    require          => Lvm::PhysicalVolume["/dev/disks/by-id/${disk_id}"]
  }

  lvm::logical_volume { "/dev/disks/by-id/${disk_id}":
    ensure       => present,
    volume_group => $disk_name,
    size         => $disk_size,
    require      => Lvm::VolumeGroup["/dev/disks/by-id/${disk_id}"]
  }

  lvm::filesystem { "/dev/disks/by-id/${disk_id}":
    ensure  => present,
    fs_type => 'ext4',
    options => '-m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard',
    require => Lvm::LogicalVolume["/dev/disks/by-id/${disk_id}"]
  }

  mount {"/mnt/disks/${disk_name}":
    ensure  => 'mounted',
    device  => "/dev/disks/by-id/${disk_id}",
    fstype  => 'ext4',
    require => Lvm::Filesystem["/dev/disks/by-id/${disk_id}"]
  }
}
