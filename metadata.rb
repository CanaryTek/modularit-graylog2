maintainer        "Kuko Armas, CanaryTek"
maintainer_email  "kuko@canarytek.com"
license           "Apache 2.0"
description       "Installs and configures Graylog2"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"
recipe            "modularit-graylog2", "Installs and configures Graylog2"

%w{apt yum java apache2 mongodb elasticsearch build-essential rvm}.each do |pkg|
  depends pkg
end

%w{redhat centos ubuntu debian}.each do |os|
  supports os
end
