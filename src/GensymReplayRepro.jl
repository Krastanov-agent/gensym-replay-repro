module GensymReplayRepro

"""
Define a top-level helper function with a `gensym`d name and immediately
assert that only one method exists for it.

Normal package loading is fine because each macro expansion creates a distinct
helper name. During `JET.report_package`, Revise/JuliaInterpreter replay can
reuse the same `gensym`d top-level name across separate expansions, which
turns the second `only(methods(...))` into a failure.
"""
macro define_checked_helper(arg)
    helper = gensym(:checked_helper)
    println("define_checked_helper gensym = ", helper)
    func_expr = quote
        function $helper($arg)
            nothing
        end
    end
    helperfn = Core.eval(__module__, func_expr)
    only(methods(helperfn, Tuple))
    return :(nothing)
end

eval(quote
    @define_checked_helper x::Int
end)

@define_checked_helper x::String

end
