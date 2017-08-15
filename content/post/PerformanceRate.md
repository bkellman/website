+++
date = "2016-04-20T12:00:00"
draft = false
tags = ["ROC", "AUC","Sensitivity","Specificty"]
title = "Classification Performance: The rate of change of Sensitivity and Specificity"
math = true
summary = """
Examining the rate of change of sensitivity and specificity as an indicator of classifier performance.
"""

[header]
image = ""
caption = ""

+++

Confusion Matrix|Disease    | No Disease
--------|--------|------
Test +|True Positive (TP)     | False Positive (FP)
Test -|False Negative (FN)   | True Negative (TN)

Recognition of "only" cases $$ Specificty = TN/N = TN/(TN+FP) $$
Recognition of "all" cases $$ Sensitivity = TP/P = TP/(TP+FN) $$

We can describe two normal distributions we would like to distish as $\mathcal{N}(\mu_0,\sigma_0^2)$ and $\mathcal{N}(\mu_1,\sigma_1^2)$. For a threshold, $t$,

Confusion Matrix|Disease    | No Disease
--------|--------|------
Test +| $ TP = Pr( X > t \| 1 ) $     | $ FP = Pr( X > t \| 0 ) $
Test -|$ FN = Pr( X < t \| 1 ) $   | $ TN = Pr( X < t \| 0 ) $

Let's expand $TP$ with the cumulative distribution function (CDF,$\Phi$):

$$TP = Pr(X>t|1) = 1-\Phi(z) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{z} e^{\frac{-t^2}{2}} dt $$

$$TP  = 1-\Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $$

$$TP =  1-\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{ \left(\frac{t-\mu_1}{\sigma_1}\right) } e^{\frac{-t^2}{2}} dt $$

Confusion Matrix|Disease    | No Disease
--------|--------|------
Test +| $ 1-\Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $     | $ 1-\Phi \left(\frac{t-\mu_0}{\sigma_0}\right) $
Test -|$ \Phi \left(\frac{t-\mu_1}{\sigma_1}\right) $   | $ \Phi \left(\frac{t-\mu_0}{\sigma_0}\right) $

## Now we can re-write Sensitivity and Specificity in terms of CDF with respect to the threshold

Recognition of "only" cases 
$$ Specificty = TN/N = TN/(TN+FP) $$

$$ = \frac{\Phi \left(\frac{t-\mu_0}{\sigma_0}\right)}{\Phi \left(\frac{t-\mu_0}{\sigma_0}\right) + \left(1-\Phi \left(\frac{t-\mu_1}{\sigma_1}\right)\right)} $$

# Measures

## Intersection of Sensitivity and Specificity
> maximum for both

## d(Sensitivity)/dt=0 and d(Specificity)/dt=0
> maximum for each

## Difference between the intersection and derivatives
> difference in each maximum is the global performance
