require 'json'
shared_context 'inbound message is opType:4' do
  # Added as friend (including canceling block).
  let(:json) do
    {
      'result' => [
        {
          'content' => {
            'params' => ['ueddddddddddddddddddddddddddddddd', nil, nil],
            'message' => nil,
            'reqSeq' => 0,
            'revision' => 317,
            'opType' => 4
          },
          'createdTime' => 1_460_520_625_677,
          'eventType' => '138311609100106403',
          'from' => 'u20666666666666666666666666666666',
          'fromChannel' => 1_341_301_815,
          'id' => 'WB1519-3333333333',
          'to' => ['uefffffffffffffffffffffffffffffff'],
          'toChannel' => 1_444_444_444
        }
      ]
    }.to_json
  end
end

shared_context 'inbound message is contentType:1' do
  let(:json) do
    {
      'result' => [
        {
          'content' => {
            'toType' => 1,
            'createdTime' => 1_460_449_091_058,
            'from' => 'ueddddddddddddddddddddddddddddddd',
            'location' => nil,
            'id' => '4111111111111',
            'to' => ['uefffffffffffffffffffffffffffffff'],
            'text' => 'bot apiから来るテキスト',
            'contentMetadata' => {
              'AT_RECV_MODE' => '2',
              'EMTVER' => '4'
            },
            'deliveredTime' => 0,
            'contentType' => 1,
            'seq' => nil
          },
          'createdTime' => 1_460_449_091_085,
          'eventType' => '138311609000106303',
          'from' => 'u20666666666666666666666666666666',
          'fromChannel' => 1_341_301_815,
          'id' => 'WB1522-3333333333',
          'to' => ['uefffffffffffffffffffffffffffffff'],
          'toChannel' => 1_444_444_444 }
      ]
    }.to_json
  end
end

shared_context 'inbound message is contentType:2' do
  let(:json) do
    {
      'result' => [
        {
          'content' => {
            'toType' => 1,
            'createdTime' => 1_460_449_091_058,
            'from' => 'ueddddddddddddddddddddddddddddddd',
            'location' => nil,
            'id' => '4111111111111',
            'to' => ['uefffffffffffffffffffffffffffffff'],
            "originalContentUrl" => "http://example.com/original.jpg",
            "previewImageUrl" => "http://example.com/preview.jpg",
            'contentMetadata' => {
              'AT_RECV_MODE' => '2',
              'EMTVER' => '4'
            },
            'deliveredTime' => 0,
            'contentType' => 2,
            'seq' => nil
          },
          'createdTime' => 1_460_449_091_085,
          'eventType' => '138311609000106303',
          'from' => 'u20666666666666666666666666666666',
          'fromChannel' => 1_341_301_815,
          'id' => 'WB1522-3333333333',
          'to' => ['uefffffffffffffffffffffffffffffff'],
          'toChannel' => 1_444_444_444 }
      ]
    }.to_json
  end
end

shared_context 'outbound expected message is contentType:1' do
  let(:expected_hash) do
    {
      to: ['ufffff'],
      toChannel: 1_383_378_250, # Fixed value
      eventType: '138311608800106203', # Fixed value
      content: {
        contentType: 1,
        toType: 1,
        text: 'テスト送信'
      }
    }
  end
end

shared_context 'outbound expected message is contentType:12' do
  let(:markup_json) do
    {
      canvas: {
        width: 1040,
        height: 1040,
        initialScene: 'scene1'
      },
      images: {
        image1: {
          x: 0,
          y: 0,
          w: 1040,
          h: 1040
        }
      },
      actions: {
        openHomepage: {
          type: 'web',
          text: 'Open our homepage.',
          params: {
            linkUri: 'https://twitter.com/hoppiestar'
          }
        },
        showItem: {
          type: 'web',
          text: 'Show item.',
          params: {
            linkUri: 'https://twitter.com/hoppiestar/status/719483889526288384'
          }
        }
      },
      scenes: {
        scene1: {
          draws: [
            {
              image: 'image1',
              x: 0,
              y: 0,
              w: 1040,
              h: 1040
            }
          ],
          listeners: [
            {
              type: 'touch',
              params: [0, 0, 1040, 520],
              action: 'openHomepage'
            },
            {
              type: 'touch',
              params: [0, 520, 1040, 520],
              action: 'showItem'
            }
          ]
        }
      }
    }
  end

  let(:expected_hash) do
    {
      to: ['ufffff'],
      toChannel: 1_383_378_250, # Fixed value
      eventType: '138311608800106203', # Fixed value
      content: {
        contentType: 12,
        toType: 1,
        contentMetadata: {
          DOWNLOAD_URL: 'https://images.example.com/img',
          SPEC_REV: '1',
          ALT_TEXT: 'Please visit our homepage and the item page you wish.',
          MARKUP_JSON: markup_json.to_json
        }
      }
    }
  end
end
