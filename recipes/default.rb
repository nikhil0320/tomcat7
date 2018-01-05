#
# Cookbook:: tomcat7
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'PPA' do
	command 'add-apt-repository ppa:openjdk-r/ppa'
end

execute 'update' do
	command 'apt-get update' 
end
execute 'install-java' do
	command 'apt-get install openjdk-8-jdk -y'
end	
#execute 'install-python' do
#        command 'apt-get install python2.7'
#end
#execute 'install-pip' do
#        command 'apt-get install python-pip'
#end
execute 'install-awscli' do
        command 'apt-get install awscli -y'
end
package 'tomcat7'

service 'tomcat7' do
        action:start
end

execute 'set-path' do
	command 'echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/default/tomcat7'
end 

template "/tmp/aws.sh" do 
  source "copy.erb" 
  owner "root" 
  group "root" 
  mode "0644" 
end

execute 'sh /tmp/aws.sh' do
 command 'sh /tmp/aws.sh'
end
service 'tomcat7' do
        action:restart
end


