using Documenter, Bitly

makedocs(
    modules = [Bitly],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Tyler Beason",
    sitename = "Bitly.jl",
    pages = Any["Main" => "index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/tbeason/Bitly.jl.git",
    push_preview = true
)
