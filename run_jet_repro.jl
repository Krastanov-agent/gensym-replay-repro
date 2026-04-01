using Pkg

pkg_root = @__DIR__
envdir = mktempdir(prefix="gensym-replay-jet-")

Pkg.activate(envdir; shared=false)
Pkg.add("JET")
Pkg.develop(path=pkg_root)
Pkg.instantiate()

using JET
using GensymReplayRepro

println("Plain `using GensymReplayRepro` succeeded.")
println("Next step intentionally reproduces the JET/Revise `gensym()` replay collision.")

rep = JET.report_package(GensymReplayRepro; target_modules=(GensymReplayRepro,))
println(rep)
println("JET_REPORT_COUNT=$(length(JET.get_reports(rep)))")
