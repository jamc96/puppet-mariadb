require 'spec_helper'

describe 'mariadb::service' do
    context "on Redhat" do
      let(:facts) {{}}

      it { is_expected.to compile }
      it {
        is_expected.to contain_service('mysqld')
        .with(
          ensure: 'running',
        )
      }
    end
end
