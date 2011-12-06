\name{methodNames}
\Rdversion{1.1}
\alias{methodNames}
\alias{methodNames,RubyClass-method}
\alias{methodNames,RubyObject-method}

\title{
Get the names of the Ruby methods for this Ruby object.
}
\description{
 This function allows the R user to find the names of the 
 methods available for a given object/instance.
 We can get all of the methods or just those from
 this class and not its super-class.
}
\usage{
methodNames(x, super = TRUE, ...)
}
\arguments{
  \item{x}{the reference to the Ruby object}
  \item{super}{a logical value indicating whether we want the methods from all of the super-classes or just the
   immediate class.}
  \item{\dots}{additional parameters for methods. Not used currently.}
}
\value{
A character vector giving the names of all the available methods.
}
\references{

}
\author{
Duncan Temple Lang
}

\seealso{
 \code{\link{.Ruby}}
 \code{\link{.RubyNew}}
 \code{\link{RubyClass-class}}
}
\examples{

}
\keyword{programming}

