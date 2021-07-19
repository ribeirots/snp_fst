#!/usr/bin/env Rscript
library(ggplot2)
args = commandArgs(trailingOnly=TRUE)

# args[1] = directory. e.g FRht_ZI
# args[2] =  arm. e.g. X
# args[3] =  simdata. e.g. X

directory = args[1]
arm = args[2]
simdata = args[3]

bin100 <- function(datablist,count_label, target_stat_id=1, enrich=F){
  bins_0to100 <- data.frame(seq(0.005,0.995,0.01))
  bins_0to100$count <- 0
  bin_index <- 1
  for(b in seq(0,0.9900001,0.0100000001)){
    if(b < 0.99){
      bins_0to100$count[bin_index] <- length(datablist[,target_stat_id][datablist[,target_stat_id]>=b & datablist[,target_stat_id] < (b+0.01)])
    } else {
      bins_0to100$count[bin_index] <- length(datablist[,target_stat_id][datablist[,target_stat_id]>=b & datablist[,target_stat_id] < (b+0.01)])
    }
    bin_index <- bin_index + 1
  }
  names(bins_0to100)[1] <- names(datablist[target_stat_id])
  bins_0to100$scale <- count_label
  
  total_obs <- sum(bins_0to100$count)

  bins_0to100$prob <- 0
  bin_index = 1
  
  if(enrich==T){
    for(c in bins_0to100$count){
      bins_0to100$prob[bin_index] <- c/(total_obs/100) # enrichment given 100 bins
      bin_index = bin_index + 1
    }
  } else {
    for(c in bins_0to100$count){
      bins_0to100$prob[bin_index] <- c/total_obs # %
      bin_index = bin_index + 1
    }  
  }

  return(bins_0to100)
}

# db_empirical, db_sim with count # e.g. sim_re_bin(emp_snp_pv, sim_snp_pv, "SNP")
sim_re_bin <- function(empdb, simdb, class_label, stat_label= "enrichment"){
  bins_1to100 <- data.frame(seq(0.005,0.995,0.01))
  names(bins_1to100)[1] <- 'pv'
  
  bins_1to100$enrichment <- 0

  empcount_total <- sum(empdb$count)
  simcount_total <- sum(simdb$count)
  
  for(b in seq(1,100)){
      expected_emp <- (empcount_total*simdb$count[b])/simcount_total
      if(expected_emp == 0 & empdb$count[b] == 0){
        bins_1to100$enrichment[b] <- 1
      } else { 
        bins_1to100$enrichment[b] <- empdb$count[b]/expected_emp
        }
      
  }
  
  bins_1to100$scale <- class_label
  
  return(bins_1to100)
}

directory3 = directory
if(directory == 'FRht_RG'){
  directory3 = 'FR_RG'
} else if(directory == 'FRht_ZI'){
  directory3 = 'FR_ZI'
} else if(directory == 'EF_FRht'){
  directory3 = 'EF_FR'
}


# make file names
filename = paste(directory3,'/emp_pvalue_',directory,'_',arm,'_sim',simdata,'.txt',sep='') # _rec05plus
print(filename)
sim_filename = paste(directory3,'/sim_emp_pvalue_',directory,'_',arm,'_sim',simdata,'.txt',sep='')

# read files
file_emp = read.csv(filename, sep='\t') # Start, End, WindowFST, MaxSNPFST, MaxSNPPosition, RecRate, WindowPvalue, SNPPvalue
file_sim = read.csv(sim_filename, sep='\t') # WindowFST, MaxSNPFST, WindowPvalue, SNPPvalue, RecRate

setwd(directory3)

# Read files
emp_snp_dist <- data.frame(fst = file_emp$MaxSNPFST)
sim_snp_dist <- data.frame(fst = file_sim$MaxSNPFST)

emp_win_dist <- data.frame(fst = file_emp$WindowFST)
sim_win_dist <- data.frame(fst = file_sim$WindowFST)

# FST SNP - Empirical x Simulated
emp_data <- bin100(emp_snp_dist, 'Empirical')
sim_data <- bin100(sim_snp_dist, 'Simulated')
comb_pvalue <- rbind(emp_data,sim_data)
fst_title = paste('SNP FST - ',directory3,'-',arm,'- model:',simdata)
ggfst <- ggplot(comb_pvalue) + geom_point(aes(x = fst, col = scale,y = prob), size=2) + ylab('Proportional Count') + xlab('FST (at 0.01 intervals)') + ggtitle(fst_title) + scale_color_manual(values=c("turquoise3", "orange2")) + theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"), plot.title = element_text(size=22, face='bold'))
figname = paste(paste('snp_fst',directory,arm,'sim',simdata,sep='_'),'.jpeg',sep='')
ggsave(filename=figname, plot = ggfst, width = 10, height = 8, dpi = 150, units = "in", device='jpeg')  

# FST Window - Empirical x Simulated
emp_data <- bin100(emp_win_dist, 'Empirical')
sim_data <- bin100(sim_win_dist, 'Simulated')
comb_pvalue <- rbind(emp_data,sim_data)
fst_title = paste('Window FST - ',directory3,'-',arm,'- model:',simdata)
ggfst <- ggplot(comb_pvalue) + geom_point(aes(x = fst, col = scale,y = prob), size=2) + ylab('Proportional Count') + xlab('FST (at 0.01 intervals)') + ggtitle(fst_title)  + scale_color_manual(values=c("turquoise3", "orange2")) + theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"), plot.title = element_text(size=22, face='bold'))
figname = paste(paste('win_fst',directory,arm,'sim',simdata,sep='_'),'.jpeg',sep='')
ggsave(filename=figname, plot = ggfst, width = 10, height = 8, dpi = 150, units = "in", device='jpeg')  

######################
# Enrichment #

# Get p-value data
emp_wind_p_dist <- data.frame(pv = file_emp$WindowPvalue)

emp_snp_p_dist <- data.frame(pv = file_emp$SNPPvalue)
sim_snp_p_dist <- data.frame(pv = file_sim$SNPPvalue)


# Make enrichment bins
emp_win_pv <- bin100(emp_wind_p_dist, 'Window', enrich=T)
sim_snp_pv <- bin100(sim_snp_p_dist, 'SNP', enrich=T)
emp_snp_pv <- bin100(emp_snp_p_dist, 'SNP', enrich=T)

# Calculate SNP enrichment based on Sim Expectation
snp_e <- sim_re_bin(emp_snp_pv, sim_snp_pv, "SNP")
# Re-format window enrichment to match SNP
win_pv <- emp_win_pv
names(win_pv)[4] <- 'enrichment'
win_e <- win_pv[,c(1,4)]
win_e$scale <- 'Window'
comb_pvalue <- rbind(win_e,snp_e)

# Enrichment Plots
# Raw data
enri_title <- paste('P-value enrichment - ',directory3,'-Chr',arm,'- model:',simdata)
ggenrich <- ggplot(comb_pvalue) + geom_point(aes(x = pv, col = scale,y = enrichment), size=2) + ylab('P-value Enrichment (Observed / Expected)') + xlab('p-value (at 0.01 intervals)') + ggtitle(enri_title) + geom_hline(yintercept=1, size=2, col='black', linetype ='dashed') + scale_color_manual(values=c("turquoise3", "orange2")) + theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"), plot.title = element_text(size=20, face='bold'))
figname = paste(paste('enrich_pvalue',directory,arm,'sim',simdata,sep='_'),'.jpeg',sep='')
ggsave(filename=figname, plot = ggenrich, width = 10, height = 8, dpi = 150, units = "in", device='jpeg')  

#Log
win_e$enrichment2 <- log(win_e$enrichment)
snp_e$enrichment2 <- log(snp_e$enrichment)
comb_pvalue <- rbind(win_e,snp_e)

enri_title <- paste('P-value enrichment - ',directory3,'-Chr',arm,'- model:',simdata)
ggenrich <- ggplot(comb_pvalue) + geom_point(aes(x = pv, col = scale,y = enrichment2), size=2) + ylab('ln(P-value Enrichment) (Obs/Exp)') + xlab('p-value (at 0.01 intervals)') + ggtitle(enri_title) + geom_hline(yintercept=0, size=2, col='black', linetype ='dashed') + scale_color_manual(values=c("turquoise3", "orange2")) + theme(axis.text=element_text(size=14), axis.title=element_text(size=16,face="bold"), plot.title = element_text(size=20, face='bold')) 
figname = paste(paste('enrich_pvalue_ln',directory,arm,'sim',simdata,sep='_'),'.jpeg',sep='')
ggsave(filename=figname, plot = ggenrich, width = 10, height = 8, dpi = 150, units = "in", device='jpeg') 
