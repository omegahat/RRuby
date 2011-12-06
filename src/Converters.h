#ifndef CONVERTERS_H
#define CONVERTERS_H

#include "RRuby.h"

SEXP convertRubyToR(VALUE val, SEXP converter);
VALUE getRubyObjectFromR(SEXP r_obj);
VALUE convertRToRuby(SEXP val, SEXP converter);

#endif
