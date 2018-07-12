require 'spec_helper'

describe 'mariadb::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      # compile manifest
      it { is_expected.to compile }
      it { is_expected.to compile.with_all_deps }
    end
  end
end
