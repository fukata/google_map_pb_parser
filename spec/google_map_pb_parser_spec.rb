RSpec.describe GoogleMapPbParser do
  it "has a version number" do
    expect(GoogleMapPbParser::VERSION).not_to be nil
  end

  it "parse pb parameter" do
    pb = '!1m18!1m12!1m3!1d3717.560901381966!2d99.5956620927018!3d21.288842013619135!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!2sStanding%20Buddha!5e0!3m2!1sja!2sth!4v1576440979089!5m2!1sja!2sth'
    expected = {
      "1"=>{
        "1"=>{
          "1"=>{
            "1"=>{ :raw=>"1d3717.560901381966", :type=>"d", :value=>"3717.560901381966" },
            "2"=>{ :raw=>"2d99.5956620927018", :type=>"d", :value=>"99.5956620927018" },
            "3"=>{ :raw=>"3d21.288842013619135", :type=>"d", :value=>"21.288842013619135" }
          },
          "3"=>{
            "1"=>{ :raw=>"1i1024", :type=>"i", :value=>"1024" },
            "2"=>{ :raw=>"2i768", :type=>"i", :value=>"768" }
          },
          "2"=>{ :raw=>"2i768", :type=>"i", :value=>"768" },
          "4"=>{ :raw=>"4f13.1", :type=>"f", :value=>"13.1" }
        },
        "4"=>{ :raw=>"4f13.1", :type=>"f", :value=>"13.1" },
        "3"=>{
          "1"=>{
            "1"=>{ :raw=>"1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d", :type=>"s", :value=>"0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d" },
            "2"=>{ :raw=>"2sStanding%20Buddha", :type=>"s", :value=>"Standing%20Buddha" }
          },
          "2"=>{ :raw=>"2sStanding%20Buddha", :type=>"s", :value=>"Standing%20Buddha" }
        },
        "2"=>{ :raw=>"2sStanding%20Buddha", :type=>"s", :value=>"Standing%20Buddha" },
        "5"=>{ :raw=>"5e0", :type=>"e", :value=>"0" }
      },
      "5"=>{
        "1"=>{ :raw=>"1sja", :type=>"s", :value=>"ja" },
        "2"=>{ :raw=>"2sth", :type=>"s", :value=>"th" }
      },
      "3"=>{
        "1"=>{:raw=>"1sja", :type=>"s", :value=>"ja"},
        "2"=>{:raw=>"2sth", :type=>"s", :value=>"th"}
      },
      "2"=>{:raw=>"2sth", :type=>"s", :value=>"th"},
      "4"=>{:raw=>"4v1576440979089", :type=>"v", :value=>"1576440979089"}
    }
    expect(GoogleMapPbParser.parse(pb)).to eq(expected)
  end
end
