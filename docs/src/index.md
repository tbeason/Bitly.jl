# Bitly.jl

[Bitly.jl](https://github.com/tbeason/Bitly.jl) is a Julia package for accessing the [Bitly API](https://dev.bitly.com). [Bitly](https://bitly.com) is a popular link shortening service.


## Example

```julia
b = BitlyToken() # loads API Key
S = shorten(b,"https://docs.julialang.org/en/v1/")
S.link # is http://bit.ly/2Us5Vl7
```

## API Key

Accessing the API requires obtaining a Generic Access Token.

 1. You can log on to your Bitly account to generate a Generic Access Token.
 2. You can use the `requestBitlyToken(username,password)` function to do the same.

```@docs
requestBitlyToken
```

### Saving the Access Token

The access token does not automatically persist across sessions. You need to save it (using one of two methods) if you would like it to do so.

#### ENV variable

From the Julia REPL, just do
```julia
ENV["BITLY_ACCESS_TOKEN"] = "yourbitlykey"
```

#### Key file

In the file `~/.bitlyrc`, store the key by itself.

```julia
keyfile = "~/.bitlyrc"
open(keyfile,"w") do file
    println(file,"yourbitlykey")
    end
```


### Using the Access Token

Create an instance of `BitlyToken` either by passing the key in as an argument or it will look for it in the appropriate environment variable or file.

```@docs
BitlyToken
```

## Link Shortening

You have an ugly long link and want a short one?

```@docs
shorten
```

## Link Expansion

You have a short uninformative link and want the long one?

```@docs
expand
```

## Link Clicks

Let's be real. Nobody is clicking your links. Here is how to prove it.

```@docs
clicks
```

