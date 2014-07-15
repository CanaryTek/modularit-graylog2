#
# Author:: Sebastian Wendel
# Cookbook Name:: graylog2
# Attribute:: default
#
# Copyright 2012, SourceIndex IT-Services
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

## Override attributes for dependency cookbooks
# Use JDK version 7 (needed by graylog2-web-interface)
set['java']['jdk_version'] = '7'
# Use a recent elasticsearch version
set.elasticsearch[:version]       = "0.90.10"
set.elasticsearch[:host]          = "http://download.elasticsearch.org"
set.elasticsearch[:repository]    = "elasticsearch/elasticsearch"
set.elasticsearch[:filename]      = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
set.elasticsearch[:download_url]  = [node.elasticsearch[:host], node.elasticsearch[:repository], node.elasticsearch[:filename]].join('/')

default['graylog2']['project_url'] = "http://github.com/Graylog2"

default['graylog2']['server_version'] = "0.20.0-rc.1"
default['graylog2']['server_file'] = "graylog2-server-#{node['graylog2']['server_version']}.tgz"
default['graylog2']['server_download'] = "#{node['graylog2']['project_url']}/graylog2-server/releases/download/#{node['graylog2']['server_version']}/#{node['graylog2']['server_file']}"
#default['graylog2']['server_checksum'] = "b2f8951a7effc1c3b617482bea0c79427f801f4034525adb163d041c34707fc1"

default['graylog2']['servicewrapper_url'] = "http://sourceforge.net/projects/wrapper/files/wrapper/Wrapper_3.5.25_20140612/wrapper-delta-pack-3.5.25.tar.gz/download"

# Password for web admin user
default['graylog2']['web_password']="changeme"

default['graylog2']['web_version'] = "0.20.0-rc.1"
default['graylog2']['web_file'] = "graylog2-web-interface-#{node['graylog2']['web_version']}.tgz"
default['graylog2']['web_download'] = "#{node['graylog2']['project_url']}/graylog2-web-interface/releases/download/#{node['graylog2']['web_version']}/#{node['graylog2']['web_file']}"
default['graylog2']['web_checksum'] = "b2f8951a7effc1c3b617482bea0c79427f801f4034525adb163d041c34707fc1"

default['graylog2']['server_path'] = "/usr/share/graylog2-server"
default['graylog2']['server_bin'] = "#{node['graylog2']['server_path']}/bin"
default['graylog2']['server_wrapper'] = "#{node['graylog2']['server_path']}/wrapper"
default['graylog2']['server_syslog4j'] = "#{node['graylog2']['server_path']}/syslog4j"
default['graylog2']['server_etc'] = "/etc/graylog2-server"
default['graylog2']['server_pid'] = "/var/run/graylog2-server"
default['graylog2']['server_lock'] = "/var/lock/graylog2-server"
default['graylog2']['server_logs'] = "/var/log/graylog2-server"
default['graylog2']['server_user'] = "graylog2"
default['graylog2']['server_group'] = "graylog2"
default['graylog2']['server_port'] = 5140

default['graylog2']['web_path'] = "/usr/share/graylog2-web"
default['graylog2']['web_bin'] = "#{node['graylog2']['web_path']}/bin"
default['graylog2']['web_wrapper'] = "#{node['graylog2']['web_path']}/wrapper"
default['graylog2']['web_etc'] = "/etc/graylog2-web"
default['graylog2']['web_pid'] = "/var/run/graylog2-web"
default['graylog2']['web_lock'] = "/var/lock/graylog2-web"
default['graylog2']['web_logs'] = "/var/log/graylog2-web"
default['graylog2']['web_user'] = "graylog2-web"
default['graylog2']['web_group'] = "graylog2-web"

default['graylog2']['email_type'] = "smtp"
default['graylog2']['email_host'] = "127.0.0.1"
default['graylog2']['email_tls'] = "true"
default['graylog2']['email_port'] = "25"
default['graylog2']['email_auth'] = "plain"
default['graylog2']['email_user'] = nil
default['graylog2']['email_passwd'] = nil
default['graylog2']['email_address'] = "graylog2@#{node['fqdn']}" 
default['graylog2']['email_domain'] = node['fqdn']

default['graylog2']['mongo_host'] = "127.0.0.1"
default['graylog2']['mongo_port'] = 27017
default['graylog2']['mongo_maxconnections'] = 150
default['graylog2']['mongo_database'] = "graylog2"
default['graylog2']['mongo_auth'] = "false" 
default['graylog2']['mongo_user'] = "graylog2"
default['graylog2']['mongo_passwd'] = "graylog2"
default['graylog2']['mongo_replica'] = "localhost:27017,localhost:27018,localhost:27019"
default['graylog2']['mongo_collection'] = "50000000"


default['graylog2']['elastic_host'] = "127.0.0.1"
default['graylog2']['elastic_host'] = "127.0.0.1"
default['graylog2']['elastic_port'] = 9200
default['graylog2']['elastic_index'] = "graylog2"

default['graylog2']['send_stream_alarms'] = true
default['graylog2']['send_stream_subscriptions'] = true
default['graylog2']['stream_alarms_cron_minute'] = "*/15"
default['graylog2']['stream_subscriptions_cron_minute'] = "*/15"
