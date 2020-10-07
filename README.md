## Simulating divergence between populations of _Drosophila melanogaster_

This project aims to measure the expected distribution of allele frequencies differences between wild populations of _Drosophila melanogaster_ under neutrality and compare it to empirical distributions. Of special interest, is the number of fixed differences between populations: how many fixed differences would we expect under neutrality and how many did we actually find? Is there a surplus of fixed differences in real populations? Similar questions will be asked for "highly differentiated SNPs."  In this case, we could ask how many sites have FST higher than 0.5 and how many do we find?

#### Demography Simulation

Demographic simulations are based on the full demographic model and parameters from a Pool Lab's recent publication (Sprengelmeyer et al. 2020). 

In order to perform our simulations, we calculate theta based on the pre-growth ancestral population size multiplied by the mutation rate (####, source) multiplied by 100 (we are simulating 100bp without recombination). Additionally, we applied a correction based on the Zambian nucleotide diversity, since Sprengelmeyer and collaborators used only supposedly neutral sites and we are interested in genome-wide patterns, we divided their measure of genetic diversity for Zambia (###) by the genome-wide value calculated in the NEXUS project (###, source). We then multiplied theta by the corrected by and used this number as the theta in our simulation.

As Sprengelmeyer and collegues, we are simulating models based on parameters for three chromosomes: X, 2R and 3L, due to the available sample size of inversion free genomes for these chromosomes. We are using all the 9 populations (Kafue, Zambie, South Africa, Rwanda, Cameroon, Ethiopia (Lowland and Highland), Egypt and France) for the X model. We are not using Ethyopia lowland in the 3L model. We are not using Ethyopia lowland nor Egypt in the 2R model.

**Challenges so far:**
- The ms output does not seem to be producing the expected number of samples (rows) in all the replicate simulations
- The nucleotide diversity is much higher than the empirical measures.
- The ratio between the nucleotide diversity between two given populations is different in the simulated and empirical data. This suggests that simply correcting theta to modify the genetic diversity won't replicate similar levels of empirical diversity for all the populations.

#### Empirical Analyses

I have calculated nucleotide diversity, dxy, and FST in the empirical data using the following scripts:
- add script names in this list.

#### Simulation versus Empirical data

To compare simulated and empirical data I am currently using chi-square test in the counts of alleles at a given FST threshold. I need to improve this script and make sure this is a suitable method for this task.

*At a closer inspection, ratio differences only seems very different for FR. I will investigate population labeling issues.*