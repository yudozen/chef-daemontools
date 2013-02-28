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
