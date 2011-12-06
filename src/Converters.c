#include "RRuby.h"
#include "Converters.h"

/*XXX Deal with reference counting/garbage colection */
SEXP
makeRubyObjectRef(VALUE val)
{
    SEXP klass, ans;
    const char *className;
    switch(TYPE(val)) {
    case RUBY_T_CLASS:
	className = "RubyClass";
	break;
    case RUBY_T_MODULE:
	className = "RubyModule";
	break;
    case RUBY_T_OBJECT:
	className = "RubyObject";
	break;
    case RUBY_T_HASH:
	className = "RubyHash";
	break;
    case RUBY_T_ARRAY:
	className = "RubyArray";
	break;
    default:
	PROBLEM "Need to add R class definition and support for Ruby reference type %d", TYPE(val)
	    ERROR;
	break;
    }
    PROTECT(klass = MAKE_CLASS(className));
    PROTECT(ans = NEW(klass));
    SET_SLOT(ans, Rf_install("ref"), R_MakeExternalPtr((void *) val, Rf_install(className), R_NilValue));
    UNPROTECT(2);
    return(ans);
}

VALUE
getRubyObjectFromR(SEXP r_obj)
{
  SEXP ref;
  VALUE val;
  ref = GET_SLOT(r_obj, Rf_install("ref"));
  val = (VALUE) R_ExternalPtrAddr(ref);
  return(val);
}

SEXP
convertRubyArrayToR(VALUE ar)
{
    int len = RARRAY_LEN(ar), i;
    SEXP tmp, ans = R_NilValue;
    VALUE el;


    PROTECT(ans = NEW_LIST(len));
    for(i = 0; i < len; i++) {
	el = rb_ary_entry(ar, i);
	tmp = convertRubyToR(el, R_NilValue);
	SET_VECTOR_ELT(ans, i, tmp);
    }
    UNPROTECT(1);
    return(ans);
}


typedef struct {
    SEXP els;
    SEXP names;
    int i;
} RHashData;


int
collectHash(VALUE key, VALUE el, void *udata)
{
    RHashData *data = (RHashData *)udata;
    SET_VECTOR_ELT(data->els, data->i, convertRubyToR(el, R_NilValue));
    SET_STRING_ELT(data->names, data->i, mkChar(StringValuePtr(key)));
    data->i++;
    return(ST_CONTINUE);
}

SEXP
convertRubyHashToR(VALUE val)
{
    int len = RHASH_SIZE(val), i;
    SEXP tmp, ans = R_NilValue, names;
    VALUE el;
    RHashData data;

   
    PROTECT(ans = NEW_LIST(len));
    PROTECT(names = NEW_CHARACTER(len));

    data.els = ans;
    data.names = names;
    data.i = 0;

    rb_hash_foreach(val, collectHash, (void*) &data);

    SET_NAMES(ans, names);
    UNPROTECT(2);

    return(ans);
}




SEXP
convertRubyToR(VALUE val, SEXP converter)
{
  SEXP r_ans = R_NilValue;
  int numProtect = 0;
  enum ruby_value_type type;


  if(FIXNUM_P(val))
    return(ScalarReal(FIX2LONG(val)));
  if(NIL_P(val))
    return(R_NilValue);

  if(TYPEOF(converter) == LGLSXP && !LOGICAL(converter)[0]) {
      return(makeRubyObjectRef(val));
  }

  type = TYPE(val);

  switch(type) {

    case RUBY_T_STRING:
      return(mkString(StringValuePtr(val)));
      break;
    case RUBY_T_FLOAT:
      return(ScalarReal(RFLOAT_VALUE(val)));
      break;
    case RUBY_T_BIGNUM:
      return(ScalarReal(NUM2DBL(val)));
      break;
    case RUBY_T_TRUE:
    case RUBY_T_FALSE:
      return(ScalarLogical(val == Qtrue));
      break;
    case RUBY_T_OBJECT:
    case RUBY_T_MODULE:
    case RUBY_T_CLASS:
	return(makeRubyObjectRef(val));
      break;
    case RUBY_T_ARRAY:
	return(convertRubyArrayToR(val));
      break;
    case RUBY_T_HASH:
	return(convertRubyHashToR(val));
      break;
    case RUBY_T_SYMBOL:
	return(mkString( rb_id2name(SYM2ID(val))));
      break;

  default:
      PROBLEM "not converting Ruby type %d", type
	  WARN;


  }

  if(numProtect)
    UNPROTECT(numProtect);

  return(r_ans);
}


VALUE
convertRToRuby(SEXP val, SEXP converter)
{
   int n = Rf_length(val);
   int type = TYPEOF(val);

   if(n == 1) {
       switch(type) {
       case LGLSXP:
	   return(LOGICAL(val)[0] ? Qtrue : Qfalse);
	   break;
       case INTSXP:
	   return(INT2NUM(INTEGER(val)[0]));
	   break;
       case STRSXP:
	   return(rb_str_new2(CHAR(STRING_ELT(val, 0))));
	   break;
       case REALSXP:
	   return(rb_float_new(REAL(val)[0]));
	   break;

       }
   } else {

       VALUE ans, el;
       int i;
       ans = rb_ary_new2(n);

       for(i = 0; i < n; i++) {
	   switch(type) {
	   case LGLSXP:
	       el = LOGICAL(val)[i] ? Qtrue : Qfalse;
	       break;
	   case INTSXP:
	       el = INT2NUM(INTEGER(val)[i]);
	       break;
	   case STRSXP:
	       el = rb_str_new2(CHAR(STRING_ELT(val, i)));
	       break;
	   case REALSXP:
	       el = rb_float_new(REAL(val)[i]);
	       break;
	   default:
	       PROBLEM "unhandled conversion of R to Ruby %d", type
		   ERROR;
	       break;
	   }
	   rb_ary_store(ans, i, el);
       }
       return(ans);
   }

   return(Qnil);
}
