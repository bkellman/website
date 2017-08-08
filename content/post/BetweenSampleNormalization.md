+++
date = "2016-04-20T12:00:00"
draft = false
tags = ["RNAseq", "Normalization","FPKM","BSN","BetweenSampleNormalization"]
title = "Examining the basis for between sample normalization"
math = true
summary = """
A shallow dive into the stated justification for between normalization. A valid decent against FPKM. 
"""

[header]
image = ""
caption = ""

+++

## *opinion currently under-review (as of 8/7/2016)*

A friend pointed out to me recently that I should not be using FPKM for between sample comparisons and sent me [*this blog post*](https://haroldpimentel.wordpress.com/2014/12/08/in-rna-seq-2-2-between-sample-normalization/). I had some thoughts about its validity and wanted to write them down.

I believe the example used in this blogpost is not an reasonable. This prompted me to play a bit with the numbers and examine the robustness of FPKM in this respect.

Clearly, FPKM (or library normalized counts) breaks down at 5 genes when 1 has a 20-fold increase in differential expression. That breakdown is indicated by the differential expression induced in all the other, stabely expressed, genes.
I've retooled the example above in general terms: 
Normalized Count Treatment = Count_Gene_i / (Count_Gene_i x StableGenes + Count_Gene_Funky x FunkyGenes) 


$$NC_t = C_i / (C_i G_s + C_f G_f)$$
$$NC_t = 5/(5(5)+75(1)) = 0.05$$


The concern is that this number diverges from the previous normalized count though it shouldn't: 
$$NC_c = 0.16 = 2/(2(5)+2(1))$$

**As was pointed out in the blogplost, $NC_t \not= NC_c$ and that is incorrect.**

We can specify the expected Fold-Change for Stable genes as:
 $$E[FC] =  NC_t / NC_c $$
using "'" to denote the shift is observed expression, we can expand Fold change of a stable gene to:

$$E[FC] = \frac{ C_i' / (C_i'  G_s + C_f'  G_f) }{ C_i / (C_i  G_s + C_f  G_f) }$$

in the control condition $C_f = C_i$. So we can rewrite the above fold change as:

$$ = \frac{ C_i' / (C_i' G_s + C_f' G_f) }{ C_i / (C_i G_s+G_f) } $$

$$= \frac{ C_i' / (C_i' G_s + C_f' G_f) } { 1 / (G_s+G_f) } $$


$$= \frac{ C_i' }{ (C_i' G_s + C_f' G_f) }  {  (G_s+G_f) }$$

We can simplify by assuming that the funky genes will have an average of a 20-fold increase in expression. An average fold change of 20 is actually a good indication that there is something wrong with your design but I will get to that in a moment). Therefore $C_f' = 20C_i'$

$$= \frac{ C_i' }{ (C_i' G_s + 20 C_i' G_f) }  {  (G_s+G_f) }$$


$$= \frac{ 1 }{ ( G_s + 20 G_f) }  {  (G_s+G_f) }$$


$$= \frac{  (G_s+G_f)}{( G_s + 20  G_f) } $$

**Actually, an expected or "average" value for fold change is 1.** There should be some upregulated, some down regulated, but on average, the expected fold-change of significantly differentially expressed genes is 1. That means that, on average, in a well-designed experiment: $E[C_f'] = 1C_i'$
$$E[FC]= \frac{  (G_s+G_f)}{( G_s + G_f) } = 1$$

**Once we correct the irregularly high fold change, the expected Fold-Change for Stable genes $E[FC]= 1$**

**Let's ignore the issue of the unrealistic fold-change for a moment**

We should also consider that $G_f <<< G_s$. While $G_f$ is considered high if it comes close to 1,000 differentially expressed genes, $G_s$ in humans is typically between 20,000 and 150,000 depending on the annotation.
Therefore, we can say that there are 2-4 orders of magnitude seperating $G_f$ and $G_s$. Considering this, we can maintain the non-zero average fold change and approximate the above statement as:

$$= \frac{  G_s+G_f}{ G_s + 20  G_f } $$
$$= \frac{  G_s+\epsilon}{ G_s + 20 \epsilon } $$
$$= \frac{  G_s}{ G_s  } $$


Again, we find that with a realistic ratio of $G_f:G_s$, we expect a fold-change in stable genes close to 1 with a margin of error of 2-4 orders of magnitude.

The problem with this example is it assumes a poorly designed or poorly controlled experiment where the average differential expression is 20-fold. If we, remove this mistake from the example, stable gene differential expression goes to 1 which is correct.