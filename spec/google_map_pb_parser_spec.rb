RSpec.describe GoogleMapPbParser do
  it "has a version number" do
    expect(GoogleMapPbParser::VERSION).not_to be nil
  end

  it "parse pb parameter" do
    pb = '!1m18!1m12!1m3!1d3717.560901381966!2d99.5956620927018!3d21.288842013619135!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!2sStanding%20Buddha!5e0!3m2!1sja!2sth!4v1576440979089!5m2!1sja!2sth'
    expected = [
      {
        :id=>'1',
        :raw=>"1m18",
        :type=>"m",
        :value=> [
          {
            :id=>'1',
            :raw=>"1m12",
            :type=>"m",
            :value=> [
              {
                :id=>'1',
                :raw=>"1m3",
                :type=>"m",
                :value=> [
                  {:id=>'1', :raw=>"1d3717.560901381966", :type=>"d", :value=>"3717.560901381966"},
                  {:id=>'2', :raw=>"2d99.5956620927018", :type=>"d", :value=>"99.5956620927018"},
                  {:id=>'3', :raw=>"3d21.288842013619135", :type=>"d", :value=>"21.288842013619135"}
                ]
              },
              {
                :id=>'2',
                :raw=>"2m3",
                :type=>"m",
                :value=> [
                  {:id=>'1', :raw=>"1f0", :type=>"f", :value=>"0"},
                  {:id=>'2', :raw=>"2f0", :type=>"f", :value=>"0"},
                  {:id=>'3', :raw=>"3f0", :type=>"f", :value=>"0"}
                ]
              },
              {
                :id=>'3',
                :raw=>"3m2",
                :type=>"m",
                :value=> [
                  {:id=>'1', :raw=>"1i1024", :type=>"i", :value=>"1024"},
                  {:id=>'2', :raw=>"2i768", :type=>"i", :value=>"768"}
                ]
              },
              {:id=>'4', :raw=>"4f13.1", :type=>"f", :value=>"13.1"}
            ]
          },
          {
            :id=>'3',
            :raw=>"3m3",
            :type=>"m",
            :value=> [
              {
                :id=>'1',
                :raw=>"1m2",
                :type=>"m",
                :value=> [
                  {:id=>'1', :raw=>"1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d", :type=>"s", :value=>"0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d"},
                  {:id=>'2', :raw=>"2sStanding%20Buddha", :type=>"s", :value=>"Standing%20Buddha"}
                ]
              }
            ]
          },
          {:id=>'5', :raw=>"5e0", :type=>"e", :value=>"0"}
        ]
      },
      {
        :id=>'3',
        :raw=>"3m2",
        :type=>"m",
        :value=> [
          {:id=>'1', :raw=>"1sja", :type=>"s", :value=>"ja"},
          {:id=>'2', :raw=>"2sth", :type=>"s", :value=>"th"}
        ]
      },
      {:id=>'4', :raw=>"4v1576440979089", :type=>"v", :value=>"1576440979089"},
      {
        :id=>'5',
        :raw=>"5m2",
        :type=>"m",
        :value=> [
          {:id=>'1', :raw=>"1sja", :type=>"s", :value=>"ja"},
          {:id=>'2', :raw=>"2sth", :type=>"s", :value=>"th"}
        ]
      }
    ]
    expect(GoogleMapPbParser.parse(pb)).to eq(expected)
  end

  it "embed url to normal url" do
    embed_url = 'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3717.5945138538577!2d99.5945486!3d21.2875125!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30d4417bb9d2cb77%3A0x3aa5ca84cbdd9e7d!2sStanding%20Buddha!5e0!3m2!1sja!2sth!4v1577557617608!5m2!1sja!2sth'
    expected = 'https://www.google.com/maps/place/@21.2875125,99.5945486,17z/data=!4m5!3m4!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!8m2!3d21.2875125!4d99.5945486'
    expect(GoogleMapPbParser.to_normal_url(embed_url)).to eq(expected)
  end
end
