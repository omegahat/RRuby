\name{RubyInit}
\Rdversion{1.1}
\alias{RubyInit}
\alias{RubyFinalize}
\title{
 Functions to start and end the running of the Ruby interpreter.
}
\description{
 These functions allow the R programmer to start and stop 
  a Ruby interpreter within an R session.

  These should not be used when embedding R within Ruby.
}
\usage{
RubyInit(name = "embeddedInR", args = character())
}
\arguments{
  \item{name}{the name to use for the Ruby interpreter to "suggest" how it was instantiated.
  This would ordinarily be the name of the Ruby script that was being interpreted.}
 \item{args}{a character vector that can be used to specify the command line options
  for starting the Ruby interpreter.}
}
\value{
 \code{RubyInit} returns a logical value \code{TRUE} to indicate that the interpreter was started.
}
\references{
Ruby C-level API Documentation, e.g. \url{http://dev.rubycentral.com/pickaxe}
}
\author{
Duncan Temple Lang
}


\seealso{
\code{\link{.Ruby}}
\code{\link{.RubyRequire}}, ec.
}
\examples{
}
\keyword{programming}

