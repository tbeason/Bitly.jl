# Bitly.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tbeason/Bitly.jl.svg?branch=master)](https://travis-ci.com/tbeason/Bitly.jl)
[![codecov.io](http://codecov.io/github/tbeason/Bitly.jl/coverage.svg?branch=master)](http://codecov.io/github/tbeason/Bitly.jl?branch=master)
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/Bitly.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://tbeason.github.io/Bitly.jl/dev)



[Bitly.jl](https://github.com/tbeason/Bitly.jl) is a Julia package for accessing the [Bitly API](https://dev.bitly.com). [Bitly](https://bitly.com) is a popular link shortening service.


## Preview

```julia
julia> using Bitly

julia> b = BitlyToken()
Bitly API Connection
        url: https://api-ssl.bitly.com
        token: # hidden for my safety :)


julia> S = shorten(b,"https://docs.julialang.org/en/v1/")
(link = "https://bit.ly/2Us5Vl7", response = Dict{String,Any}("deeplinks" => Any[],"created_at" => "2020-03-28T00:59:02+0000","references" => Dict{String,Any}("group" => "https://api-ssl.bitly.com/v4/groups/Bk3ri4m2q8i"),"archived" => false,"id" => "bit.ly/2Us5Vl7","custom_bitlinks" => Any[],"link" => "https://bit.ly/2Us5Vl7","tags" => Any[],"long_url" => "https://docs.julialang.org/en/v1/"))

julia> S.link
"https://bit.ly/2Us5Vl7"
```

## Details


Right now the package implements only basic methods associated with the service:
- obtaining token via `requestBitlyToken`
- link shortening via `shorten`
- link expansion via `expand`
- click statistics via `clicks`


This package is very much incomplete, but it does provide the basic functionality. It does what I need it to do.

I am open to pull requests that extend or improve existing features.

See the [documentation](https://tbeason.github.io/Bitly.jl/stable) for more information.

## Disclaimer

I am not affiliated in any way with Bitly, nor does this package come with any guarantees.

