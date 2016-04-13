describe Linelife::MessageDeliverer do
  describe '.new' do
    subject { Linelife::MessageDeliverer.new.deliverer }
    it 'uses ssl' do
      expect(subject).to be_use_ssl
    end

    it 'host is trialbot-api.line.me' do
      expect(subject.address).to eq 'trialbot-api.line.me'
    end

    it 'port is 443' do
      expect(subject.port).to be 443
    end

    context 'given proxy' do
      before do
        expect_any_instance_of(Linelife::MessageDeliverer).to \
          receive(:proxy_url) { 'http://user:pass@p.example.com' }.at_least(1)
      end

      it 'proxy_address is not nil' do
        expect(subject.proxy_address).to eq 'p.example.com'
      end

      it 'proxy_user is not nil' do
        expect(subject.proxy_user).to eq 'user'
      end

      it 'proxy_pass is not nil' do
        expect(subject.proxy_pass).to eq 'pass'
      end
    end

    context 'not given proxy' do
      before do
        expect_any_instance_of(Linelife::MessageDeliverer).to \
          receive(:proxy_url) { nil }.at_least(1)
      end

      it 'proxy_address is nil' do
        expect(subject.proxy_address).to be nil
      end

      it 'proxy_user is nil' do
        expect(subject.proxy_user).to be nil
      end

      it 'proxy_pass is nil' do
        expect(subject.proxy_pass).to be nil
      end
    end
  end
end
