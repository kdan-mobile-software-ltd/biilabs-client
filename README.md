# Biilabs Client

To post/get tangles on IoTA

## Install

from console

    gem install biilabs-client

with bundler, write follwing line in your Gemfile

    gem 'biilabs-client'

## Usage
setup endpoint in config/biilabs-client.yml
check config/biilabs-client_example.yml for example

require on demand

    irb> require 'biilabs-client'

convert string to trytes

    irb> "Hello World".to_trytes.value
    # "RBTC9D9DCDEAFCCDFD9DSC"

convert trytes string to normal string

    irb> Trytes.new("RBTC9D9DCDEAFCCDFD9DSC").to_string
    # "Hello World"

post tangle to IoTA via Biilabs

    irb> BiilabsClient.new.post_tangle('my tag', 'my message')
    # {
    #   "hash"=>"LTSDZIYLKSLQHCOZPHWWCNUNSFZCVLTZELARIONAGR9RGY9ZXC9J9AYHUZMGEODZXI9AOMJ9PCKB99999",
    #   "signature_and_message_fragment"=>"ADMDEAADTCGDGDPCVCTC9999...",
    #   "tag"=>"ADMDEAHDPCVC999999999999999",
    #   ...
    # }

get tangle from IoTA via Biilabs

    irb> BiilabsClient.new.get_tangle('LTSDZIYLKSLQHCOZPHWWCNUNSFZCVLTZELARIONAGR9RGY9ZXC9J9AYHUZMGEODZXI9AOMJ9PCKB99999')
    # {
    #   "hash"=>"LTSDZIYLKSLQHCOZPHWWCNUNSFZCVLTZELARIONAGR9RGY9ZXC9J9AYHUZMGEODZXI9AOMJ9PCKB99999",
    #   "signature_and_message_fragment"=>"ADMDEAADTCGDGDPCVCTC9999...",
    #   "tag"=>"ADMDEAHDPCVC999999999999999",
    #   ...
    # }


get tangles by tag from IoTA via Biilabs

    irb> BiilabsClient.new.get_tangle_by_tag('ADMDEAHDPCVC999999999999999')
    # {
    #   "transactions"=>[{
    #     "hash"=>"LTSDZIYLKSLQHCOZPHWWCNUNSFZCVLTZELARIONAGR9RGY9ZXC9J9AYHUZMGEODZXI9AOMJ9PCKB99999",
    #     "signature_and_message_fragment"=>"ADMDEAADTCGDGDPCVCTC9999...",
    #     "tag"=>"ADMDEAHDPCVC999999999999999",
    #     ...
    #   }]
    # }
