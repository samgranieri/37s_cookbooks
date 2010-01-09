default.ree[:version] = "1.8.7-2009.10"
#default.ree[:version] = "1.8.6-20090610"
default.ree[:architecture] = kernel[:machine] == "x86_64" ? "amd64" : "i386"