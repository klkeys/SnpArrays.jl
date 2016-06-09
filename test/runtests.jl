include("../src/SnpArrays.jl")

module SnpArraysTest

using SnpArrays

if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end


info("Constructors")

@time sa = SnpArray("../docs/hapmap3")
@time sabm = SnpArrayBM("../docs/hapmap3")

info("getindex")
for i=1:10
    for j=1:10
        @test sa[i,j] == sabm[i,j]
    end
end

for i=1:100
    for j=1:100
        sa[i,j] = (false,true)
        @test sa[i,j] == (false,true)
        sabm[i,j] = (false,true)
        @test sabm[i,j] == (false,true)
    end
end


info("summarize")
@time maf, _, _, _ = summarize(sa)
@time mafbm, _, _, _ = summarize(sabm)
_, m, n = size(sabm)
for i=1:n
    @test maf[i] == mafbm[i]
end

info("grm")
@time grm(sa; method=:GRM)
@time grm(sabm; method=:GRM)

info("mom")
@time grm(sa; method=:MoM)
@time grm(sabm; method=:MoM)

end # module
