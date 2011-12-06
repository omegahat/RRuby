\name{getRubyClass}
\Rdversion{1.1}
\alias{getRubyClass}
\alias{coerce,character,RubyClass-method}

\title{Find the RubyClass object by name}
\description{
 This function resolves the Ruby class corresponding
 to the specified class name.
 We can use this, or an instance of the class, to 
 perform reflection and find out about methods and slots/fields. 
}
\usage{
getRubyClass(name)
}
\arguments{
  \item{name}{a character string giving the name of the Ruby class of interest.}
}

\value{
 An object of class \code{\link{RubyClass-class}}.
}
\references{
The \code{rb_path2class} C routine in the Ruby C-level API
}
\author{
Duncan Temple Lang
}

\seealso{
 \code{\link{.Ruby}}
}
\examples{

}
\keyword{programming}

