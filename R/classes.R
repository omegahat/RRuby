setClass("RubyRef", representation(ref = 'externalptr'))
setClass("RubyObject", contains = "RubyRef")
setClass("RubyClass",  contains = "RubyRef")
setClass("RubyModule",  contains = "RubyRef")

setClass("RubyCollection",  contains = "RubyRef")
setClass("RubyHash",  contains = "RubyCollection")
setClass("RubyArray",  contains = "RubyCollection")

if(!isGeneric("lapply"))
  setGeneric("lapply", function (X, FUN, ...)  standardGeneric("lapply"))

setMethod("lapply", "RubyArray",
           function (X, FUN, ...)  {
             lapply(seq(length = length(X)), 
                      function(i)
                         FUN(X[[i]], ...))
           })

setMethod("lapply", "RubyHash",
           function (X, FUN, ...)  {
             lapply(names(X), 
                      function(i)
                         FUN(X[[i]], ...))
           })


setMethod("[[", "RubyArray", 
           function(x, i, j, ..., convert = NULL) {
             .Call("R_rb_ary_entry", x, as.integer(i), convert)
           })

setMethod("[[", "RubyHash", 
           function(x, i, j, ..., convert = NULL) {
             .Call("R_rb_hash_aref", x, as.character(i), convert)
           })


setMethod("length", "RubyHash",
        function(x) {
         .Call("R_rb_hash_size", x)
        })

setMethod("length", "RubyArray",
        function(x) {
         .Call("R_rb_array_size", x)
        })

setAs("RubyRef", "list",
        function(from) {
           .Call("R_rb_ref_convert", from, NULL)
        })

setAs("RubyRef", "character",
        function(from) {
           as.character(unlist(as(from, "list")))
        })


setAs("RubyRef", "integer",
        function(from) {
           as.integer(unlist(as(from, "list")))
        })
setAs("RubyRef", "numeric",
        function(from) {
           as.numeric(unlist(as(from, "list")))
        })

setAs("RubyRef", "logical",
        function(from) {
           as.logical(unlist(as(from, "list")))
        })

setMethod("names", "RubyHash", function(x) unlist(.Ruby(x, "keys")))

setMethod("names", "RubyObject", function(x) unlist(x$instance_variables())) # XXX remove the unlist when we handle homogeneous arrays.

setAs("character", "RubyClass", 
        function(from) 
           .Call("R_rb_get_class", from))

getRubyClass = 
function(name)
 as(name, "RubyClass")


setMethod("$", "RubyRef",
           function(x, name) {
              function(...)
                .Ruby(x, name, ...)
           })

setAs("RubyObject", "RubyClass",
        function(from)
	  .Call("R_rb_class_of", from))

setMethod("[[", "RubyRef",
          function(x, i, j, ..., convert = NULL) {
              id = as.character(i)
              if(substring(id, 1, 1) != "@")
                 id = paste("@", id, sep = "")
             .Call("R_rb_iv_get", x, id, convert)
          })

setGeneric("methodNames", function(x, super = TRUE, ...) standardGeneric("methodNames"))
setMethod("methodNames", "RubyObject",
           function(x, super = TRUE, convert = NULL, ...)
              methodNames(as(x, "RubyClass"), super, convert))

setMethod("methodNames", "RubyClass",
           function(x, super = TRUE, convert = NULL, ...)
              unlist(.Call("R_rb_class_instance_methods", x, convert, as.logical(super))))
