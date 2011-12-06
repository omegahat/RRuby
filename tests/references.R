library(RRuby)
RubyInit()
.RubyRequire(system.file("sampleRuby", "global.rb", package = "RRuby"))

a = .RubyNew("A")
ar = a[["a", convert = FALSE]]
length(ar)

h = a[["h", convert = FALSE]]
length(h)

ar[[2]]

