# GensymReplayRepro.jl

Minimal standalone reproduction of `JET.report_package` replaying macro
expansions through Revise/JuliaInterpreter in a way that reuses a plain
`gensym()`d top-level binding name.

## What It Shows

- plain package loading succeeds
- `JET.report_package` replays the macro expansion through Revise/JuliaInterpreter
- the replay can reuse the same `gensym()`d helper name across:
  one helper created by `eval(quote ... end)` and one helper created by a
  later direct top-level macro expansion
- the second replayed expansion then sees multiple methods for what it
  expected to be a fresh helper binding and fails in `only(methods(...))`

## Run

```bash
julia --startup-file=no --history-file=no /workdir/dev/QuantumSavory/GensymReplayRepro.jl/run_jet_repro.jl
```

Expected behavior on the buggy path:

- `Plain using GensymReplayRepro succeeded.`
- then `JET.report_package(...)` throws `ArgumentError: Collection has multiple elements, must contain exactly 1 element`
