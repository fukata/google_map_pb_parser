require "google_map_pb_parser/version"

module GoogleMapPbParser
  class Error < StandardError; end

  def self.to_normal_url(embed_url)
    embed_url = URI.unescape(embed_url)
    if m = embed_url.match(%r|^https://(www\.google\.com)/maps/embed\?pb=(.+)|)
      host = m[1]
      pb = m[2]
      result = parse(pb)

      lat = result.dig(0, :value, 0, :value, 0, :value, 2, :value)
      lng = result.dig(0, :value, 0, :value, 0, :value, 1, :value)
      place_id = result.dig(0, :value, 1, :value, 0, :value, 0, :value)
      data = decode_result(
        [
          {
            id: '4',
            type:'m',
            value: [
              {
                id: '3',
                type: 'm',
                value: [
                  {id: '1', type: 's', value: place_id},
                  {
                    id: '8',
                    type: 'm',
                    value: [
                      {id: '3', type: 'd', value: lat},
                      {id: '4', type: 'd', value: lng},
                    ]
                  }
                ]
              }
            ]
          }
        ]
      )

      zoom = '17z'
      url = "https://#{host}/maps/place/@#{lat},#{lng},#{zoom}/data=#{data}"
      url
    else
      raise Error.new("Invalid url. url=#{embed_url}")
    end
  end

  def self.decode_result(result)
    data = ''
    result.each do |v|
      id = v[:id]
      type = ''
      value = ''
      case v[:type]
      when 'm'
        type = 'm'
        value = _map_size(v[:value]).to_s
        data += "!#{id}#{type}#{value}"
        data += decode_result(v[:value])
      else
        type = v[:type]
        value = URI.escape(v[:value])
        data += "!#{id}#{type}#{value}"
      end
    end
    data
  end

  def self._map_size(result)
    size = 0
    result.each do |v|
      case v[:type]
      when 'm'
        size += _map_size(v[:value]) + 1
      else
        size += 1
      end
    end
    size
  end

  def self.parse(pb)
    params = pb.split('!').reject{|s| s == nil || s == ''}
    _parse([], params)
  end

  def self._parse(result, params, from=0, to=0)
    _params = from > 0 && to > 0 ? params[from, to] : params
    i = 0
    len = _params.length
    while (i < len) do
      param = _params[i]
      if m = param.match(/([0-9]+)([a-z]{1})(.+)/)
        id = m[1]
        type = m[2]
        value = m[3]

        case type
        when 'm'
          result.push({
            id: id,
            raw: param,
            type: 'm',
            value: _parse([], _params, i + 1, value.to_i)
          })
          # Since it is added at the end of the loop, subtract 1 here.
          i += value.to_i
        else
          result.push({
            id: id,
            raw: param,
            type: type,
            value: value,
          })
        end
      else
        raise Error.new("Parse error. param=#{param}")
      end
      i += 1
    end

    result
  end
end
