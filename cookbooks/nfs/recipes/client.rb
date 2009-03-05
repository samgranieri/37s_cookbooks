if node[:nfs_mounts]
  node[:nfs_mounts].each do |target, config|
    directory target do
      recursive true
      owner config[:owner]
      group config[:owner]
    end
    mount target do
      fstype "nfs"
      options %(rw,soft,intr)
      device config[:device]
      dump 0
      pass 0
    end
  end
else
  Chef::Log.warn "You included the NFS client recipe without defining nfs mounts."
end