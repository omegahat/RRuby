#include "RRuby.h"

void
R_ruby_process_options(int argc, char **argv)
{
  ruby_process_options(argc, argv);
}

SEXP
R_rb_load_file(SEXP r_filename)
{
  const char *filename;
  void *ans;
  filename = CHAR(STRING_ELT(r_filename, 0));
  ans = rb_load_file(filename);
  return(R_MakeExternalPtr(ans, Rf_install("void"), R_NilValue));
}

#if 0
SEXP
R_ruby_run()
{
  int status;
  void *arg = NULL;
  status = ruby_run(arg);

  return(ScalarInteger(status));
}
#endif


void
R_ruby_script(const char **args)
{
  ruby_script(args[0]);
}

SEXP
R_ruby_eval_string_protect(SEXP r_str)
{
  int state;
  const char *str;
  VALUE ans;
  SEXP r_ans = R_NilValue;

  str = CHAR(STRING_ELT(r_str, 0));
  ans = rb_eval_string_protect(str, &state);
  if(state) {
    PROBLEM "error in evaluating Ruby expression %s:", str
      ERROR;
  }

  return(r_ans);
}


