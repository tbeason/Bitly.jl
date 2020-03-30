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

Right now the package implements only basic methods associated with the service:
- obtaining token via `requestBitlyToken`
- link shortening via `shorten`
- link expansion via `expand`
- click statistics via `clicks`

I am open to pull requests that extend or improve existing features.
