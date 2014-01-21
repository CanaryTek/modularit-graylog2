#
# Cookbook Name:: graylog2
# Recipe:: web-interface
#
# Copyright 2012, SourceIndex IT-Serives
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

group node['graylog2']['web_group'] do
    system true
end

user node['graylog2']['web_user'] do
    home node['graylog2']['web_path']
    comment "services user for graylog2-web"
    gid node['graylog2']['web_group']
    system true
end

root_dirs = [
  node['graylog2']['web_path'],
  node['graylog2']['web_bin'],
  node['graylog2']['web_wrapper'],
]

root_dirs.each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "0755"
  end
end

user_dirs = [
  node['graylog2']['web_pid'],
  node['graylog2']['web_lock'],
  node['graylog2']['web_logs'],
  node['graylog2']['web_path'],
  node['graylog2']['web_etc']
]

user_dirs.each do |dir|
  directory dir do
    owner node['graylog2']['web_user']
    group node['graylog2']['web_group']
    mode "0755"
  end
end

unless FileTest.exists?("#{node['graylog2']['web_bin']}/graylog2-web-interface")
  bash "install graylog2-web-interface sources from #{node['graylog2']['web_download']}" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      wget -O #{node['graylog2']['web_file']} #{node['graylog2']['web_download']}
      tar -zxf graylog2-web-interface-*.tgz
      rm -rf graylog2-web-interface-*/graylog2.conf.example
      mv -f graylog2-web-interface-*/{bin,lib,share} #{node['graylog2']['web_path']}
      chown -R #{node['graylog2']['web_user']}:#{node['graylog2']['web_group']} #{node['graylog2']['web_path']}
    EOH
  end
end

unless FileTest.exists?("#{node['graylog2']['web_wrapper']}/lib/wrapper.jar")
  bash "extract java service wrapper" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      rm -rf wrapper-delta-pack-*
      wget #{node['graylog2']['servicewrapper_url']}/$(wget -qO- http://sourceforge.net/projects/wrapper/  | grep 'small title' | cut -d'"' -f2 | cut -d'_' -f2)/wrapper-delta-pack-$(wget -qO- http://sourceforge.net/projects/wrapper/  | grep 'small title' | cut -d'"' -f2 | cut -d'_' -f2).tar.gz
      tar -zxf wrapper-delta-pack-*
      #rm -rf wrapper-delta-pack-*/conf \
      #       wrapper-delta-pack-*/src \
      #       wrapper-delta-pack-*/jdoc \
      #       wrapper-delta-pack-*/doc \
      #       wrapper-delta-pack-*/logs \
      #       wrapper-delta-pack-*/jdoc.tar.gz \
      #       wrapper-delta-pack-*/bin/*.exe \
      #       wrapper-delta-pack-*/bin/*.bat \
      #       wrapper-delta-pack-*/lib/*.dll \
      #       wrapper-delta-pack-*/lib/*demo*.* \
      #       wrapper-delta-pack-*/bin/*test*.* 
      mv wrapper-delta-pack-*/* #{node['graylog2']['web_wrapper']}
      chown -R root:root #{node['graylog2']['web_wrapper']}
      chmod -R 755 #{node['graylog2']['web_wrapper']}
    EOH
  end
end

link "#{node['graylog2']['web_path']}/conf" do
  to node['graylog2']['web_etc']
end

link "#{node['graylog2']['web_path']}/logs" do
  to node['graylog2']['web_logs']
end

template "#{node['graylog2']['web_etc']}/graylog2-wrapper.conf" do
  source "graylog2-web-wrapper.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node['graylog2']['web_etc']}/graylog2-web-interface.conf" do
  source "graylog2-web-interface.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/init.d/graylog2-web" do
    source "graylog2-web-init.erb"
    owner "root"
    group "root"
    mode 0755
end

service "graylog2-web" do
  supports :start => true
  action [:enable, :start]
end
