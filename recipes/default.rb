#
# Cookbook Name:: daemontools
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "/tmp/daemontools-0.76.tar.gz" do
	source "http://cr.yp.to/daemontools/daemontools-0.76.tar.gz"
	notifies :run, "bash[install_program]", :immediately
end

package "patch" do
	action :install
end

bash "install_program" do
	user "root"
	cwd "/tmp"
	code <<-EOH
		tar -zxf /tmp/daemontools-0.76.tar.gz
		cd admin/daemontools-0.76
		wget http://www.qmail.org/moni.csi.hu/pub/glibc-2.3.1/daemontools-0.76.errno.patch
		patch -p1 < daemontools-0.76.errno.patch
		package/install
	EOH
	action :nothing
end

# for jidou kidou
template "/etc/init/svscan.conf" do
	source "svscan.erb"
	mode 0644
	owner "root"
	group "root"
	notifies :run, "bash[start_svscan]", :immediately
end

bash "start_svscan" do
	user "root"
	code <<-EOH
		initctl reload-configuration
		initctl start svscan
	EOH
	action :nothing	
end

