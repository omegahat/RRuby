library(RRuby)
RubyInit()
.RubyRequire(system.file("sampleRuby", "global.rb", package = "RRuby"))

a = .RubyEval( "A.new" )
.Ruby(a, "withArgs", 2L, 3L)
.Ruby(a, "len", 1:10)

a[["i"]]
a[["d"]]
a[["a"]]
a[["h"]]
