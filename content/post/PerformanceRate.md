+++
date = "2016-04-20T12:00:00"
draft = false
tags = ["ROC", "AUC","Sensitivity","Specificty"]
title = "Classification Performance: The rate of change of Sensitivity and Specificity"
math = true
summary = """
Examining the rate of change of sensitivity and specificity as an indicator of classifier performance; an exersize in logistic decision making.
"""

[header]
image = ""
caption = ""

# Trash?
## Intersection of Sensitivity and Specificity
#> maximum for both

## d(Sensitivity)/dt=0 and d(Specificity)/dt=0
#> maximum for each

## Difference between the intersection and derivatives
#> difference in each maximum is the global performance



+++

## *opinion currently under-construction (as of 8/15/2016)*
## *if you have something to add, please shoot me an email!

## Confusion matrix
_|Disease    | No Disease
--------|--------|------
Test +|True Positive (TP)     | False Positive (FP)
Test -|False Negative (FN)   | True Negative (TN)

Recognition of "only" cases $$ Specificty = 1-FPR = TN/N = TN/(TN+FP) $$
Recognition of "all" cases $$ Sensitivity = TP/P = TP/(TP+FN) $$

## Logistic Regression and log-odds

Logistic Regression, developed in 1958 by David Cox, is a subdomain of regression modeling that parameterizes the relation between multiple independent observation variables and a binary dependent response variable. It was developed to calculate a probability of membership to either the "0" or "1" distribution.

The logistic regression is an adaptation of generialize linear modeling:
$$ g(x) = \beta_0 + \beta_1 x $$
where $g(x)$ is the logit function: $ ln \left( \frac{p}{1-p} \right) $.

We can describe the bimodal distribution of log-odds produced by a logistic regression  two normal distributions we would like to distish as $\mathcal{N}(\mu_0,\sigma_0^2)$ and $\mathcal{N}(\mu_1,\sigma_1^2)$. For a threshold, $t$,

## Updating the Confusion matrix to include log-odds
Confusion Matrix|Disease    | No Disease
--------|--------|------
Test +| $ TP = Pr( X > t \| 1 ) $     | $ FP = Pr( X > t \| 0 ) $
Test -|$ FN = Pr( X < t \| 1 ) $   | $ TN = Pr( X < t \| 0 ) $

Let's expand $TP$ with the cumulative distribution function (CDF,$\Phi$):

$$TP = Pr(X>t|1) = 1-\Phi(z) = 1-\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{z} e^{\frac{-t^2}{2}} dt $$

$$TP  = 1-\Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $$

$$TP =  1-\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{ \left(\frac{t-\mu_1}{\sigma_1}\right) } e^{\frac{-t^2}{2}} dt $$

Confusion Matrix|Disease    | No Disease
--------|--------|------
Test +| $ Sensitivity=1-\Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $     | $ FPR=1-\Phi \left(\frac{t-\mu_0}{\sigma_0}\right) $
Test -|$ FNR=\Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $   | $ Specificity=\Phi \left(\frac{t-\mu_0}{\sigma_0}\right) $



# Integral and Derivative of the sensitivity specificity product

## Integral: Generative AUC 

Appropriate when thresholding log-odds form a logistic regression since they are norally distributed. Calculate AUC in a close-form rather than approximating them with the trapazoial method. Trapazoids give an exact answer for the given problem but calculating them using this generative method may generalize for easily.

- does it generalize?

## Derivative: Threshold that maximizes both Sensitivity and Specificity



