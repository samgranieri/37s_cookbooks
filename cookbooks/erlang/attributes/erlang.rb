erlang Mash.new

unless erlang.has_key?(:cookie)
  24.times {
    erlang[:cookie] <<
      (i = Kernel.rand(62);
       i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
end
