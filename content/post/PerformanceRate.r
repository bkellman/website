library(mixtools)

mod = glm(vs ~ mpg , family='binomial',data=mtcars)

# the log odds ratio of outcome probabilities is a bimodal distribution
plot(density( log( mod$fitted.values / (1-mod$fitted.values) ) ))

# it can be modeled by a gaussian mixture model
gmm = normalmixEM( log( mod$fitted.values / (1-mod$fitted.values) ) )

plot(gmm,which=2)
