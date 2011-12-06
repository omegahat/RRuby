#include "RRuby.h"
#include "Converters.h"


SEXP
R_rb_class_instance_methods(SEXP r_obj, SEXP r_convert, SEXP super)
{
    SEXP r_ans;
    VALUE args[1];
    VALUE obj, ans;
    args[0] = LOGICAL(super)[0] ? Qtrue : Qfalse ;

    obj = getRubyObjectFromR(r_obj);

    if(TYPE(obj) == RUBY_T_OBJECT)
	obj = CLASS_OF(obj);

    obj = rb_cString;

    ans = rb_class_instance_methods(1, args, obj);
    return(convertRubyToR(ans, r_convert));
}



