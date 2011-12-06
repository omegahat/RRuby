\name{RubyObject-class}
\Rdversion{1.1}
\docType{class}
\alias{RubyRef-class}
\alias{RubyObject-class}
\alias{RubyModule-class}
\alias{RubyClass-class}
\alias{RubyHash-class}
\alias{RubyArray-class}
\alias{coerce,RubyObject,RubyClass-method}
\alias{names,RubyObject-method}
\alias{[[,RubyHash-method}
\alias{[[,RubyArray-method}
\alias{[[,RubyRef-method}
\alias{$,RubyArray-method}
\alias{lapply,RubyHash-method}
\alias{lapply,RubyArray-method}
\alias{names,RubyHash-method}
\alias{names,RubyObject-method}
\alias{length,RubyHash-method}
\alias{length,RubyArray-method}
\alias{$,RubyRef-method}
\alias{RubyCollection-class}

\alias{coerce,RubyRef,character-method}
\alias{coerce,RubyRef,integer-method}
\alias{coerce,RubyRef,list-method}
\alias{coerce,RubyRef,logical-method}
\alias{coerce,RubyRef,numeric-method}

\title{Class "RubyRef" and sub-classes for references to Ruby objects}
\description{
  These classes and associated methods allow us to work with Ruby
 objects  by reference within R code and to treat them much like
 R objects such as lists and named lists and invoke functions.
}
\section{Objects from the Class}{
 Objects of these classes are typically created implicitly via 
 C code that marshals objects across the R/Ruby interface.
}
\section{Slots}{
	 \describe{
    \item{\code{ref}:}{Object of class \code{"externalptr"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{RubyRef}"}, directly.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "RubyObject", to = "RubyClass")}: ... }
    \item{methodNames}{\code{signature(x = "RubyObject")}: ... }
    \item{names}{\code{signature(x = "RubyObject")}: ... }
	 }
}
\references{
Ruby C-level API
}
\author{Duncan Temple Lang}
\note{ }


\seealso{
 \code{\link{.RubyNew}}
 \code{\link{.Ruby}}
 The \code{convert} argument for most \code{.Ruby*} functions.
}
\examples{
showClass("RubyObject")
}
\keyword{classes}
