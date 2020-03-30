__precompile__()


"""
A Julia package for accessing the Bitly API. See `BitlyToken`.
"""
module Bitly

#imports
using HTTP
using JSON
using Base64: base64encode
using Printf

#exports
export BitlyToken, requestBitlyToken, shorten, expand, clicks



const BITLY_API_BASE = "https://api-ssl.bitly.com"
const BITLY_SHORTEN = joinpath(BITLY_API_BASE,"v4/shorten")
const BITLY_EXPAND = joinpath(BITLY_API_BASE,"v4/expand")
const BITLY_BITLINKS = joinpath(BITLY_API_BASE,"v4/bitlinks")

const TOKEN_LENGTH = 40
const TOKEN_ENV_NAME = "BITLY_ACCESS_TOKEN"
const TOKEN_FILE_NAME = ".bitlyrc"





# Bitly connection type
"""
A connection to the Bitly API.

Constructors
------------
- `BitlyToken()`: Token detected automatically. First, looks for the environment variable
`BITLY_ACCESS_TOKEN`, then looks for the file `~/.bitlyrc`.
- `BitlyToken(token::AbstractString)`: User specifies token directly

See [`requestBitlyToken`](@ref).
"""
mutable struct BitlyToken
    token::AbstractString
    url::AbstractString
    function BitlyToken(token, url)
        # token validation
        if length(token) > TOKEN_LENGTH
            token = token[1:TOKEN_LENGTH]
            @warn("Bitly API token too long. First $(TOKEN_LENGTH) chars used.")
        elseif length(token) < TOKEN_LENGTH
            error("Invalid Bitly API token -- token too short: $(token)")
        end
        if !all(isxdigit, token)
            error("Invalid Bitly API token -- invalid characters: $(token)")
        end
        return new(token, url)
    end
end

BitlyToken(token::AbstractString) = BitlyToken(token, BITLY_API_BASE)

token_file() = joinpath(homedir(), TOKEN_FILE_NAME)

function load_bitly_token()
    if TOKEN_ENV_NAME in keys(ENV)
        ENV[TOKEN_ENV_NAME]
    elseif isfile(token_file())
        open(token_file(), "r") do file
            rstrip(read(file, String))
        end
    else
        error("Bitly API Key not detected.")
    end
end

has_bitly_token() = TOKEN_ENV_NAME in keys(ENV) || isfile(token_file())

function BitlyToken(;verbose=false)
    token = load_bitly_token()
    verbose && println("API token loaded.")
    return BitlyToken(token)
end


function Base.show(io::IO, b::BitlyToken)
    @printf io "Bitly API Connection\n"
    @printf io "\turl: %s\n" b.url
    @printf io "\ttoken: %s\n" b.token
end


"""
`requestBitlyToken(uname,pw)`

Exchanges your username and password for an access token. Your username and password are *not stored*!

Returns a string.

Note: you can also log on to your account on Bitly and request an access token directly.
"""
function requestBitlyToken(uname::AbstractString,pw::AbstractString)
    cred = base64encode(string(uname,":",pw))
    header = ("Content-Type" => "application/x-www-form-urlencoded","Authorization" => "Basic $cred")
    r = HTTP.post(joinpath(BITLY_API_BASE,"oauth/access_token"),header)
    tok = String(r.body)
    return BitlyToken(tok)
end

"""
`shorten(b::Bitly,url::AbstractString)`

Shorten `url` to a `bit.ly/xXxXx` shortened link.

Returns a `NamedTuple` with `link` and `response` items. `link` is the `bit.ly` link, 
while `response` is the complete `JSON` response from the Bitly API.

```julia
b = BitlyToken()
S = shorten(b,"https://docs.julialang.org/en/v1/")
S.link
S.response 
```
"""
function shorten(b::BitlyToken,url::AbstractString)
    header = ("Content-Type" => "application/json","Authorization" => "Bearer $(b.token)")
    payload = Dict("long_url" => url)
    r = HTTP.post(BITLY_SHORTEN,header,JSON.json(payload))

    js = JSON.parse(String(r.body))
    link = js["link"]

    return (link=link,response=js)
end


"""
`expand(b::BitlyToken,link::AbstractString)`

Recovers the original `url` from a `bit.ly/xXxXx` shortened link.

Returns a `NamedTuple` with `long_url` and `response` items. `long_url` is the original link, 
while `response` is the complete `JSON` response from the Bitly API.

```julia
b = BitlyToken()
S = expand(b,"http://bit.ly/2Us5Vl7")
S.long_url
S.response
```
"""
function expand(b::BitlyToken,link::AbstractString)
    s = HTTP.splitpath(link)
    id = joinpath(s[end-1],s[end])

    header = ("Content-Type" => "application/json","Authorization" => "Bearer $(b.token)")
    payload = Dict("bitlink_id" => id)
    r = HTTP.post(BITLY_EXPAND,header,JSON.json(payload))

    js = JSON.parse(String(r.body))
    long_url = js["long_url"]

    return (long_url=long_url,response=js)
end




"""
`clicks(b::BitlyToken,link; summary=false,unit="day",units=-1,size=50)`

Get click information for shortened link `link`.

`summary=true` provides a single count, otherwise returns a time series.

`unit` can be `"minute"`,`"hour"`,`"day"`,`"week"`,`"month"`.

`units` is an integer representing the number of time units to query data for. Pass `-1` to return all units available.

`size` is the quantity of items to be returned.

Returns a `Dict`.
"""
function clicks(b::BitlyToken,link::AbstractString; summary::Bool=false,unit::String="day",units::Int=-1,size::Int=50)
    s = HTTP.splitpath(link)
    id = joinpath(s[end-1],s[end])

    header = ("Content-Type" => "application/json","Authorization" => "Bearer $(b.token)")
    p = summary ? joinpath(BITLY_BITLINKS,id,"clicks","summary") : joinpath(BITLY_BITLINKS,id,"clicks")
    r = HTTP.get(p,header)

    js = JSON.parse(String(r.body))

    return js
end


end # module
