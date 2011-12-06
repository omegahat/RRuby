#include "RRuby.h"
#include "Converters.h"

SEXP
R_rb_get_class(SEXP r_path)
{
   VALUE klass;
   const char * className = CHAR(STRING_ELT(r_path, 0));
   klass = rb_path2class(className);
   return(makeRubyObjectRef(klass));
}


SEXP
R_ruby_new(SEXP r_class, SEXP r_args, SEXP converter)
{
  VALUE ans, *args, klass;
  int numArgs, i;
  SEXP r_ans = R_NilValue;

  klass = getRubyObjectFromR(r_class);

  numArgs = Rf_length(r_args);
  args = (VALUE*) R_alloc(sizeof(VALUE), numArgs);
  for(i = 0; i < numArgs; i++)
      args[i] = convertRToRuby(VECTOR_ELT(r_args, i), R_NilValue);

  ans = rb_class_new_instance(numArgs, args, klass);

  r_ans = convertRubyToR(ans, converter);
  return(r_ans);
}


SEXP
R_ruby_funcall(SEXP r_obj, SEXP r_method, SEXP r_args, SEXP converter)
{
  ID id;
  const char *method = CHAR(STRING_ELT(r_method, 0));
  VALUE obj, ans, *args;
  int numArgs, i;
  SEXP r_ans = R_NilValue;

  numArgs = Rf_length(r_args);

  if(r_obj != R_NilValue)
      obj = getRubyObjectFromR(r_obj);
  else
      obj = rb_mKernel;

  id = rb_intern(method);

  if(!rb_respond_to(obj, id)) {
      PROBLEM "the ruby object does not have a method named %s", method
	ERROR;
  }

  args = (VALUE*) R_alloc(sizeof(VALUE), numArgs);
  for(i = 0; i < numArgs; i++)
      args[i] = convertRToRuby(VECTOR_ELT(r_args, i), R_NilValue);

  ans = rb_funcall2(obj, id, numArgs, args);
  
  r_ans = convertRubyToR(ans, converter);
  return(r_ans);
}


SEXP
R_rb_gv_get(SEXP r_name, SEXP r_convert)
{
  const char *name;
  VALUE val;
  name = CHAR(STRING_ELT(r_name, 0));
  val = rb_gv_get(name);
  return(convertRubyToR(val, r_convert));
}


SEXP
R_rb_iv_get(SEXP r_obj, SEXP r_name, SEXP r_convert)
{
  const char *name;
  VALUE val, obj;
  name = CHAR(STRING_ELT(r_name, 0));
  obj = getRubyObjectFromR(r_obj);
  val = rb_iv_get(obj, name);
  return(convertRubyToR(val, r_convert));
}



SEXP
R_rb_eval_string(SEXP r_cmd, SEXP r_convert)
{
  const char *cmd;
  VALUE val;
  int status = 0;

  cmd = CHAR(STRING_ELT(r_cmd, 0));
  val = rb_eval_string_protect(cmd, &status);

  if(status) {
    PROBLEM "error evaluating Ruby command: %s", cmd
      ERROR;
  }

  return(convertRubyToR(val, r_convert));
}


SEXP
R_rb_class_of(SEXP r_obj)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
   return(makeRubyObjectRef( CLASS_OF(obj)));
}

SEXP
R_rb_class_name(SEXP r_obj)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
   return(mkString( rb_obj_classname(obj)));
}



SEXP
R_rb_array_size(SEXP r_obj)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
    return(ScalarInteger(RARRAY_LEN(obj)));
}

SEXP
R_rb_hash_size(SEXP r_obj)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
    return(ScalarInteger(RHASH_SIZE(obj)));
}

SEXP
R_rb_ref_convert(SEXP r_obj, SEXP r_convert)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
    return(convertRubyToR(obj, r_convert));
}

SEXP
R_rb_ary_entry(SEXP r_obj, SEXP r_index, SEXP r_convert)
{
    VALUE obj;
    obj = getRubyObjectFromR(r_obj);
    return(convertRubyToR(rb_ary_entry(obj, INTEGER(r_index)[0] - 1), r_convert));
}

SEXP
R_rb_hash_aref(SEXP r_obj, SEXP r_index, SEXP r_convert)
{
    VALUE obj, key;
    const char *name = CHAR(STRING_ELT(r_index, 0));

    obj = getRubyObjectFromR(r_obj);
    return(convertRubyToR(rb_hash_aref(obj, ID2SYM(rb_intern(name))), r_convert));
}


