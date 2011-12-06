.RubyEval =
function(cmd, converter = NULL)
{
 .Call("R_rb_eval_string", as.character(cmd), converter)
}

.RubyGet =
function(var, converter = NULL)
{
 .Call("R_rb_gv_get", as.character(var), converter)
}

.RubyRequire =
function(file)
{
  file = path.expand(file)
  if(!file.exists(file))
     stop("No such Ruby file")

  .RubyEval(sprintf('require "%s"' , file))
}


.RubyNew =
function(class, ..., .args = list(...), converter = NULL)
{
  class = as(class, "RubyClass")

  .Call("R_ruby_new", class, .args, converter)
}

.Ruby = 
function(obj, method, ..., .args = list(...), converter = NULL)
{
  .Call("R_ruby_funcall", obj, as.character(method), .args, converter)
}
