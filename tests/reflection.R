library(RRuby)
RubyInit()
.RubyRequire(system.file("sampleRuby", "global.rb", package = "RRuby"))

a = .RubyEval( "A.new" )

methodNames(a)
.Ruby(a, "methods")

  # methods from super classes
setdiff(methodNames(a), methodNames(a, FALSE))

k = a$class()
k$superclass()
k$ancestors()

# http://www.rubycentral.com/book/ospace.html

