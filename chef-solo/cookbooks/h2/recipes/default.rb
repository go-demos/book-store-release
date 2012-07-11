# Cookbook Name:: H2 Database
# Recipe:: default
#
# Copyright 2011,
#
# All rights reserved - Do Not Redistribute

# Make sure java is installed
include_recipe("java::openjdk")

h2_ver = node["h2"]["version"]
h2_url = "http://repo2.maven.org/maven2/com/h2database/h2/1.3.168/h2-#{h2_ver}.jar"
h2_target = node["h2"]["target"]
h2_user = node["h2"]["user"]
h2_group = node["h2"]["group"]

# Create base folder
directory "#{h2_target}" do
    owner "#{h2_user}"
    group "#{h2_group}"
    mode "0755"
    action :create
end

# Fetch binary
remote_file "#{h2_target}/h2-#{h2_ver}.jar" do
    source "#{h2_url}"
    mode "0644"
    not_if {File.exists?("/usr/local/h2/h2-#{h2_ver}.jar")}
end


# Set the symlink
link "#{h2_target}/h2.jar" do
    to "#{h2_target}/h2-#{h2_ver}.jar"
    link_type :symbolic
end

# Add the init-script
template "/etc/init.d/h2" do
	source "init-h2.sh.erb"
	owner "root"
	group "root"
	mode "0755"
end

# Dedfine the service
service "h2" do
    service_name "h2"
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => false
    action [:enable, :start ]
end
