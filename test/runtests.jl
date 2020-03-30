using Bitly
using Test

const testurl = "https://docs.julialang.org/en/v1/"

@testset "Shorten" begin
    b = BitlyToken()
    @test b.url == Bitly.BITLY_API_BASE
    S = shorten(b,testurl)

    @test S.link == "https://bit.ly/2Us5Vl7"

    @test S.response["long_url"] == testurl
end


@testset "Expand" begin
    b = BitlyToken()
    S = expand(b,"https://bit.ly/2Us5Vl7")
    @test S.long_url == testurl
end

