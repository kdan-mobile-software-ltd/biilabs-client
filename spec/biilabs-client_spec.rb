describe BiilabsClient do
  before(:each) do
    @client = BiilabsClient.new
    @tag = 'my tag'
    @mssage = 'my document digest'
  end

  describe '.post_tangle' do
    it 'should return tangle info' do
      result = @client.post_tangle(@tag, @mssage)
      expect(result['hash'].to_trytes.value).to eq(result['hash'])
      expect(result['tag'].to_trytes.to_string).to eq(@tag)
      expect(result['signature_and_message_fragment'].to_trytes.to_string).to eq(@mssage)
    end
  end

  describe '.get_tangle' do
    it 'should return tangle info' do
      tangle_id = 'MYZHHPILCLXDSJNAMPGETUEKWRQCKBWQJIMNEZSQPF9ANGRNVOIVOQJNTJRNPLVPNEVLWVVGMLRK99999'
      result = @client.get_tangle(tangle_id)
      expect(result['hash'].to_trytes.value).to eq(tangle_id)
      expect(result['tag'].to_trytes.to_string).to eq(@tag)
      expect(result['signature_and_message_fragment'].to_trytes.to_string).to eq(@mssage)
    end
  end

  describe '.get_tangle_by_tag' do
    it 'should return tangles with same tag' do
      result = @client.get_tangle_by_tag(@tag)
      expect(result.first['tag'].to_trytes.to_string).to eq(@tag)
    end
  end
end
