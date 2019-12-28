require "google_map_pb_parser/version"

module GoogleMapPbParser
  class Error < StandardError; end
  # Your code goes here...

  def self.parse(pb)
    params = pb.split('!').reject{|s| s == nil || s == ''}
    _parse({}, params)
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
          result[id] = _parse({}, _params, i+1, value.to_i)
          # Since it is added at the end of the loop, subtract 1 here.
          i += value.to_i - 1
        else
          result[id] = {
            raw: param,
            type: type,
            value: value,
          }
        end
      else
        raise Error.new("parse error. param=#{param}")
      end

      i += 1
    end

    result
  end
end
