\name{.Ruby}
\Rdversion{1.1}
\alias{.Ruby}
\alias{.RubyEval}
\alias{.RubyGet}
\alias{.RubyNew}
\alias{.RubyRequire}

\title{Direct the "embedded" Ruby interpreter from R}
\description{
 These functions allow the R user to direct the embedded
 Ruby interpreter to perform useful operations.
 These include loading/requiring a Ruby file, 
 creating an instance of a Ruby class,
 invoking a Ruby method, evaluating a Ruby command
 given as a string and retrieving a global variable in the Ruby interpreter.
}
\usage{
.Ruby(obj, method, ..., .args = list(...), converter = NULL)
.RubyEval(cmd, converter = NULL) 
.RubyGet (var, converter = NULL) 
.RubyNew(class, ..., .args = list(...), converter = NULL) 
.RubyRequire(file) 
}

\arguments{
  \item{obj}{the reference to the Ruby object (of class RubyObject or RubyRef) 
      whose method is to be invoked.}
  \item{method}{a character string giving the name of the method to invoke}
  \item{\dots}{arguments to the method call}
  \item{.args}{a single list containing the arguments for the method call.
   This can be a more convenient way to pass the arguments programmatically.}
  \item{converter}{a value controlling how the resulting Ruby value is converted to R.
   This can be a logical value indicating whether to convert or leave as a reference.
   In the future, it can also be an R function or a NativeSymbolInfo object that 
   is used to perform the conversion.}
  \item{cmd}{a character string whose content is a Ruby command/expression that will be evaluated by the Ruby interpreter.}
  \item{var}{a character string giving the name of the Ruby global variable to be retrieved.}
  \item{class}{either a character string giving the name of the Ruby class or the
   the a \code{RubyClass-class} object. }
  \item{file}{a character string giving the name of the Ruby source file to be loaded.
   This will be passed to \code{\link[base]{path.expand}} and so ~ will be expanded.}
}
\details{

}
\value{
These functions typically return an arbitrary Ruby object
which is typically converted to an R object.
}
\references{

}
\author{Duncan Temple Lang}

\note{

}

\seealso{
 
}
\examples{

}
\keyword{programming}
\concept{inter system interface}
