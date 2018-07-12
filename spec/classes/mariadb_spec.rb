require 'spec_helper'
describe 'mariadb' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      #default variables 
      public_repo = 'https://yum.mariadb.org'
      packages = { 
        'MariaDB-common' => { 'require' => 'Yumrepo[mariadb]' },
        'MariaDB-server' => { 'require' => 'Package[MariaDB-client]' },
        'MariaDB-client' => { 'require' => 'Package[MariaDB-compat]' },
        'MariaDB-compat' => { 'require' => 'Package[MariaDB-common]' },
      }
      # compile manifest
      it { is_expected.to compile }
      it { is_expected.to compile.with_all_deps }
      # class containment
      it { is_expected.to contain_class('mariadb::install') }
      it { is_expected.to contain_class('mariadb::config') }
      it { is_expected.to contain_class('mariadb::service') }
      
      if os_facts[:operatingsystem] == 'RedHat'
        os_name = 'rhel'
      else
        os_name = 'centos'
      end
      # mariadb respository
      it { 
        is_expected.to contain_yumrepo('mariadb').with(
          ensure: 'present',
          name: 'mariadb', 
          baseurl: "#{public_repo}/10.0.29/#{os_name}/#{os_facts[:operatingsystemmajrelease]}/x86_64/",
          descr: 'MariaDB',
          enabled: '1', 
          gpgcheck: '1', 
          gpgkey: "#{public_repo}/RPM-GPG-KEY-MariaDB",
        )
      }
      packages.each do |key, value|
        # validate packages
        it { is_expected.to contain_package(key).with(ensure: 'present', provider: 'yum', require: value['require']) }
      end
      # config file 
      it { is_expected.to contain_file('/etc/my.cnf').with(ensure: 'present', mode: '0774', owner: 'mysql', group: 'mysql')}
      # mysql service
      it { is_expected.to contain_service('mysql').with(ensure: 'running', enable: true)}
    end
  end
end
