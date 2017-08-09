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

A friend pointed out to me recently that I should not be using FPKM for between sample comparisons and sent me [*this blog post*](https://haroldpimentel.wordpress.com/2014/12/08/in-rna-seq-2-2-between-sample-normalization/). 

# The example that caught my attention

The example in the blogpost sparked my interest. This prompted me to play a bit with the numbers and examine the robustness of library-size normalization given various challenges.

As illustrated in the blogpost, library normalized counts breaks down at 5 genes when 1 has a 20-fold increase in differential expression. That breakdown is indicated by the differential expression induced in all the other, stabely expressed, genes. For any stably expressed gene, we would expect the differential expression between the control and experimental condition to be nominal: $E[FC_{stable}]=1$. We can denote library normalized counts for gene $i$ in the control condition as $C_i$ and library normalized counts for gene $i$ in the experimental condition as $C_i'$. Counts for stable, $s$, genes will be expected to remain constant across conditions: $E[FC_s] = C_s'/C_s = 1$. While counts for differentially expressed ("funky") genes will expect to diverge across conditions: $E[FC_f]= C_f'/C_f \not= 1$. Let's begin with the assumption that $E[FC_s] = 1$.

$$E[FC_s] =  C_s'/C_s = 1$$

We know that given raw counts, $R$, and a library of counts from $G$ genes, 
$$C_s =  \frac{\text{stable gene $i$ counts}}{ \text{total counts}} = \frac{R_s}{ \sum_G R_i}$$

We can now ask if $E[FC_s] = C_s'/C_s = 1$ as expected in the given example in the blogpost.

$$ FC_s = \frac{C_s'}{C_s} = \frac{ \frac{R_s'}{ \sum_G R_i'}} {\frac{R_s}{ \sum_G R_i} } = 
\frac{ \frac{2}{ 10}} {\frac{6}{100} } = 3.\overline{3} \not=1
 $$
 
Clearly, in the given example, $FC_s\not=1$, indicating that the stable genes are erroneously differentially expressed. It is at this point, I noted some curious properties of this example including: **(1)** the extreme of the average fold-change of the differentially expressed gene ($\bar{FC_f}=20$), **(2)** the 10-fold difference in library size, and **(3)** that 25% of the genes were differentially expressed. **Of course, this was just an example, but I was curious, which if any of these factors were important to the performance of library-size normalization.**
 
------------
## A little generalization to get us going

Total counts, $\sum_G R_i$, can be expanded to seperate differentially expressed, $F$, and stable, $S$, genes by multiplying the expected counts by the number of differentially expressed and stable genes, $G_f$ and $G_s$ respectively.

$$C_s = \frac{R_s}{ \sum_G R_i} = \frac{R_s}{ E[R_s]G_s + E[R_f]G_f}$$

**This generalization allows us to expand and reorganize our understanding of influences over the expected fold change for stable genes, $E[FC_s]$.$$ We can rewrite $E[FC_s]$ in terms of raw counts and gene number:

$$E[FC_s] = C_s'/C_s = 1$$
$$E[FC_s] = \frac{\frac{R_s'}{ \sum_G R_i'}}{\frac{R_s}{ \sum_G R_i}} = 
\frac{R_s'/ (E[R_s']G_s + E[R_f']G_f)}{R_s/ (E[R_s]G_s + E[R_f]G_f)} = 1$$

**In the control condition we can assume that $E[R_s]=E[R_f]$.** This may sound odd but in the control condition, the cell has not been aggitated in any mannor that would distinguish stable genes for the genes that will be differentially expressed. Therefore, the genes that will be differentially expressed should be indistinguishable from those that wont be differetially expressed. Therefore:

$$E[FC_s] = \frac{R_s'/ (E[R_s']G_s + E[R_f']G_f)}{R_s/ (E[R_s]G_s + E[R_f]G_f)} $$
$$ = \frac{R_s'/ (E[R_s']G_s + E[R_f']G_f)}{R_s/ (E[R_s]G_s + E[R_s]G_f)} $$
$$ = \frac{R_s'/ (E[R_s']G_s + E[R_f']G_f)}{1/ (G_s + G_f)} $$
$$ = \frac{R_s'(G_s + G_f)}{ (E[R_s']G_s + E[R_f']G_f)} $$


We can further generalize the expected expression of the differentially expressed genes, $E[R_f']$, by describing them as a scaling on the base expression, $E[F_f]$. Since the base expression is a raw measurement in a different sized library, this is not an ideal comparison. We recall from earlier that $E[R_s]=E[R_f]$ in the unperturbed condition. **To further this generalization, we extend the equation $E[R_s]=E[R_f]$ to account for divergence by some fold-change, $f$, from the average base expression in the experimental condition:
$$ E[R_f'] = f(E[R_s']) $$

This equation allows us to further simplify our expression for $E[FC_s]$:
$$E[FC_s] = \frac{R_s'(G_s + G_f)}{ (E[R_s']G_s + E[R_f']G_f)} $$
$$E[FC_s] = \frac{R_s'(G_s + G_f)}{ (E[R_s']G_s + f(E[R_s'])G_f)} $$
$$E[FC_s] = \frac{(G_s + G_f)}{ (G_s + fG_f)} $$

$E[FC_s]$ is now in a more maliable form and we can begin to make some hypotheses reguarding when library-size normalization may fail.


# Stuff I think:

## (1) Influence of average fold-change of differentially expressed genes

- $E[FC_s]$ is inversely proportional to $f$.
- But $E[f]=0$ [cite or explain]. therefore, in a well designed typical experiment there is no influence

$$E[FC_s] = \frac{(G_s + G_f)}{ (G_s + fG_f)} $$
$$ = \frac{(G_s + G_f)}{ (G_s + (1)G_f)} $$
$$ = \frac{(G_s + G_f)}{ (G_s + G_f)} = 1 $$

## (2) Influence of average library-size difference 

- No terms indicating the library size survive to this description of the E[FC_s] therefore, following the assumptions noted above, we expect no influence of library-size on E[FC_s] in library-size normalized samples.

## (3) Influence of the proportion of differentially expressed genes

- The potential influence of $f$ noted in section (1), is scaled by the magnitude of $G_f$. When $G_f$ is small relative to $G_s$, the potential influcence of a non-zero $f$ will be mitigated. 
- It is typically the case that $G_f<<G_s$ since, typically, the cell is not completely transformed. In a carefully controlled experiment when only a portion of a response network is differentially expressed, truly differentially expressed genes can be on the order of 10. While interfering with global regulators like p300 could result in thousands of differentially expressed genes.
- In an experiment where $E[f]\not=0$, it is important that $G_f<<G_s$, otherwise they will compound to induce differential expression in stable genes.

# Conclusion 

If $E[f]\not=0$ and the number of differentially expressed gens is not small, library-size normalization is not reliable and will induce differential expression in stable genes.



--------------------------------------------------

## Concerns

- Is $x/E[x] = 1$? If I'm looking at E[FC] should I be using R or E[R] in the numerator?



