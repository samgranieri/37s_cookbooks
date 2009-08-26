ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")] 
set :user, ENV['USER']
set :use_sudo, false
set :gateway, "#{ENV['USER']}@dev.37signals.com"
role :kvm, "xen11", "xen12", "kvm01", "kvm02", "kvm03", "kvm04", "kvm05", "kvm06", "kvm07", "kvm08", "kvm09", "kvm13"

task :find do
  run "kvmtool list | grep #{ENV['VM']}"
end
