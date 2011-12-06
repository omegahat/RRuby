RubyInit =
function(name = "embeddedInR", args = character())
{
 .C("ruby_init")
 .C("ruby_init_loadpath")
 .C("R_ruby_script", as.character(name))
 if(length(args)) {
    args = as.character(args)
    .C("R_ruby_process_options", length(args), args)
 }

 TRUE
}


RubyFinalize =
function()
  .C("ruby_finalize")

