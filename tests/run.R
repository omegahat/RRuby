library(RRuby)
RubyInit()

.RubyRequire(system.file("sampleRuby", "global.rb", package = "RRuby"))

.RubyEval("print $x")

.RubyGet("x")
.RubyGet("gi")
.RubyGet("gd")

.RubyGet("fun")

a = .RubyEval( "A.new" )
.Ruby(a, "foo")

.Ruby(a, "withArgs", 2L, 3L)

