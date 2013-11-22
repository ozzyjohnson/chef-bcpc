
package "oozie" do
	action :upgrade
end

#TODO, this probably has dependencies on external services such as yarn and hive as well
#hopefully it starts up later :)
service "oozie" do
  action [:enable, :start]
  subscribes :restart, "template[/etc/oozie/conf/oozie-site.xml]", :delayed
  subscribes :restart, "template[/etc/oozie/conf/oozie-env.sh]", :delayed
end

directory "/etc/oozie/conf.bcpc/action-conf" do
      owner "root"
      group "root"
      mode 00755
      action :create
      recursive true
end

directory "/etc/oozie/conf.bcpc/hadoop-conf" do
      owner "root"
      group "root"
      mode 00755
      action :create
      recursive true
end

link "/etc/oozie/conf.bcpc/hadoop-conf/core-site.xml" do
  to "/etc/hadoop/conf.bcpc/core-site.xml"
end

link "/etc/oozie/conf.bcpc/hadoop-conf/hdfs-site.xml" do
  to "/etc/hadoop/conf.bcpc/hdfs-site.xml"
end

template "/etc/oozie/conf.bcpc/action-conf/hive.xml" do
  mode 0644
  source "ooz_action_hive.xml.erb"
end