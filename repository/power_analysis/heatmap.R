# Script to generate heatmap plots for power analysis
# tribeiro@wisc.edu

# It uses stringr (more info: https://github.com/tidyverse/stringr) to process the name of the scenarios
library(stringr)

# It uses ggplot2 for making the heatmpaps
library(ggplot2)

#rm(list=ls())

setwd('/media/tiago/Seagate Portable Drive/power_analysis/power_results_10k/')

heatmap_power_gg <- function(dset, varX, varY, varFill, varTitle, xLabel, yLabel, varFigname){
  dset[,3] <- round(dset[,3], digits = 2)
  gg_heatmap <- ggplot(dset, aes_string(varX, varY, fill=varFill)) + geom_tile() + scale_fill_viridis_c(option="cividis", direction=-1, name="Power") + 
    theme_light() + ggtitle(varTitle) + theme(axis.text = element_text(size = 15)) + theme(axis.title = element_text(size = 25)) +
    theme(plot.title = element_text(size=22)) + xlab(xLabel) + ylab(yLabel) + 
    geom_text(aes_string(label=varFill, size=2, colour=shQuote("white"), fontface = shQuote('bold')), show.legend=F)
  
  figname = varFigname
  ggsave(filename=figname, plot = gg_heatmap, width = 10, height = 8, dpi = 150, units = "in", device='jpeg')
  return(gg_heatmap)
}

gg_inc_fst_ss <- heatmap_power_gg(inc_fst_ss, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ss

complete_fst <- read.csv('complete_fst.txt', sep='\t')[,1:3] # ModelID, SNP_FST, winFST
incomplete_fst <- read.csv('incomplete_fst.txt', sep='\t')[,1:3] # ModelID, SNP_FST, winFST
incomplete_chi <- read.csv('incomplete_chi.txt', sep='\t')[,1:3] # ModelID, SNP_FST, winFST

complete_fst_hard_sp02 <- complete_fst[str_detect(complete_fst$ModelID, 'hard') & str_detect(complete_fst$ModelID, 'sp02'),]
complete_fst_hard_sp02
complete_fst_hard_sp05 <- complete_fst[str_detect(complete_fst$ModelID, 'hard') & str_detect(complete_fst$ModelID, 'sp05'),]
complete_fst_hard_sp05

# incomplete
incomplete_fst_ss <- incomplete_fst[str_detect(incomplete_fst$ModelID, 'ss'),]
incomplete_chi_ss <- incomplete_chi[str_detect(incomplete_chi$ModelID, 'ss'),]

incomplete_fst_ws <- incomplete_fst[str_detect(incomplete_fst$ModelID, 'ws'),]
incomplete_chi_ws <- incomplete_chi[str_detect(incomplete_chi$ModelID, 'ws'),]

incomplete_fst_LN <- incomplete_fst[str_detect(incomplete_fst$ModelID, 'LN'),]
incomplete_chi_LN <- incomplete_chi[str_detect(incomplete_chi$ModelID, 'LN'),]


##### Incomplete HN ss
inc_fst_ss = c()
for (i in 1:length(incomplete_fst_ss$ModelID)){
  pa = incomplete_fst_ss[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  inc_fst_ss = rbind(inc_fst_ss,x)
}

inc_fst_ss <- data.frame(inc_fst_ss)
names(inc_fst_ss) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ss$power <- as.numeric(inc_fst_ss$power)
plot_title = expression(italic(F[ST - MaxSNP])~" - Incomplete Sweep - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_hn_ss_snp.jpg'
gg_inc_fst_ss <- heatmap_power_gg(inc_fst_ss, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ss

### Window FST
inc_fst_ss_win = c()
for (i in 1:length(incomplete_fst_ss$ModelID)){
  pa = incomplete_fst_ss[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[3])))
  inc_fst_ss_win = rbind(inc_fst_ss_win,x)
}

inc_fst_ss_win <- data.frame(inc_fst_ss_win)
names(inc_fst_ss_win) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ss_win$power <- as.numeric(inc_fst_ss_win$power)
plot_title = expression(italic(F[ST - Window])~" - Incomplete Sweep - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_hn_ss_win.jpg'
gg_inc_fst_ss_win <- heatmap_power_gg(inc_fst_ss_win, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ss_win

## Chi
inc_chi_ss = c()
for (i in 1:length(incomplete_chi_ss$ModelID)){
  pa = incomplete_chi_ss[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  inc_chi_ss = rbind(inc_chi_ss,x)
}

inc_chi_ss <- data.frame(inc_chi_ss)
names(inc_chi_ss) <- c('init_Freq', 'final_Freq', 'power')
inc_chi_ss$power <- as.numeric(inc_chi_ss$power)
#plot_title = 'CHI - Incomplete Sweep - HN (s=0.01)'
plot_title = expression(italic("\u03A7"[MD])~" - Incomple Sweep - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_hn_ss_chi.jpg'
gg_inc_chi_ss <- heatmap_power_gg(inc_chi_ss, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_chi_ss


##### Incomplete HN ws
inc_fst_ws = c()
for (i in 1:length(incomplete_fst_ws$ModelID)){
  pa = incomplete_fst_ws[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  inc_fst_ws = rbind(inc_fst_ws,x)
}

inc_fst_ws <- data.frame(inc_fst_ws)
names(inc_fst_ws) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ws$power <- as.numeric(inc_fst_ws$power)
plot_title = expression(italic(F[ST - MaxSNP])~" - Incomple Sweep - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'inc_hn_ws_snp.jpg'
gg_inc_fst_ws <- heatmap_power_gg(inc_fst_ws, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ws

###### Window
inc_fst_ws_win = c()
for (i in 1:length(incomplete_fst_ws$ModelID)){
  pa = incomplete_fst_ws[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[3])))
  inc_fst_ws_win = rbind(inc_fst_ws_win,x)
}

inc_fst_ws_win <- data.frame(inc_fst_ws_win)
names(inc_fst_ws_win) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ws_win$power <- as.numeric(inc_fst_ws_win$power)
plot_title = expression(italic(F[ST - Window])~" - Incomple Sweep - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'inc_hn_ws_win.jpg'
gg_inc_fst_ws_win <- heatmap_power_gg(inc_fst_ws_win, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ws_win

# CHI
inc_chi_ws = c()
for (i in 1:length(incomplete_chi_ws$ModelID)){
  pa = incomplete_chi_ws[i,]
  scen = str_split_fixed(pa[1],"_",6)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  inc_chi_ws = rbind(inc_chi_ws,x)
}

inc_chi_ws <- data.frame(inc_chi_ws)
names(inc_chi_ws) <- c('init_Freq', 'final_Freq', 'power')
inc_chi_ws$power <- as.numeric(inc_chi_ws$power)
plot_title = expression(italic("\u03A7"[MD])~" - Incomple Sweep - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'inc_hn_ws_chi.jpg'
gg_inc_chi_ws <- heatmap_power_gg(inc_chi_ws, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_chi_ws



##### Incomplete LN
inc_fst_ln = c()
for (i in 1:length(incomplete_fst_LN$ModelID)){
  pa = incomplete_fst_LN[i,]
  scen = str_split_fixed(pa[1],"_",5)
  x = as.matrix(cbind(scen[4], scen[5], as.numeric(pa[2])))
  inc_fst_ln = rbind(inc_fst_ln,x)
}

inc_fst_ln <- data.frame(inc_fst_ln)
names(inc_fst_ln) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ln$power <- as.numeric(inc_fst_ln$power)
plot_title = expression(italic(F[ST - MaxSNP])~" - Incomple Sweep - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_ln_snp.jpg'
gg_inc_fst_ln <- heatmap_power_gg(inc_fst_ln, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ln



# Window
inc_fst_ln_win = c()
for (i in 1:length(incomplete_fst_LN$ModelID)){
  pa = incomplete_fst_LN[i,]
  scen = str_split_fixed(pa[1],"_",5)
  x = as.matrix(cbind(scen[4], scen[5], as.numeric(pa[3])))
  inc_fst_ln_win = rbind(inc_fst_ln_win,x)
}

inc_fst_ln_win <- data.frame(inc_fst_ln_win)
names(inc_fst_ln_win) <- c('init_Freq', 'final_Freq', 'power')
inc_fst_ln_win$power <- as.numeric(inc_fst_ln_win$power)
plot_title = expression(italic(F[ST - Window])~" - Incomple Sweep - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_ln_win.jpg'
gg_inc_fst_ln_win <- heatmap_power_gg(inc_fst_ln_win, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_fst_ln_win

# CHI
inc_chi_ln = c()
for (i in 1:length(incomplete_chi_LN$ModelID)){
  pa = incomplete_chi_LN[i,]
  scen = str_split_fixed(pa[1],"_",5)
  x = as.matrix(cbind(scen[4], scen[5], as.numeric(pa[2])))
  inc_chi_ln = rbind(inc_chi_ln,x)
}

inc_chi_ln <- data.frame(inc_chi_ln)
names(inc_chi_ln) <- c('init_Freq', 'final_Freq', 'power')
inc_chi_ln$power <- as.numeric(inc_chi_ln$power)
plot_title = expression(italic("\u03A7"[MD])~" - Incomple Sweep - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'inc_ln_chi.jpg'
gg_inc_chi_ln <- heatmap_power_gg(inc_chi_ln, 'init_Freq', 'final_Freq', 'power', plot_title, "Starting Frequency", "Ending Frequency", plot_name)
gg_inc_chi_ln


###############################################################3
###################################################################
##################################################################
## MIGRATION

migration_fst <- read.csv('migration_fst.txt', sep='\t')[,1:3] # ModelID, SNP_FST, winFST
migration_chi <- read.csv('migration_chi.txt', sep='\t')[,1:3] # ModelID, SNP_FST, winFST

migration_fst_ss <- migration_fst[str_detect(migration_fst$ModelID, 'ss'),]
migration_chi_ss <- migration_chi[str_detect(migration_chi$ModelID, 'ss'),]

migration_fst_ws <- migration_fst[str_detect(migration_fst$ModelID, 'ws'),]
migration_chi_ws <- migration_chi[str_detect(migration_chi$ModelID, 'ws'),]

migration_fst_LN <- migration_fst[str_detect(migration_fst$ModelID, 'LN'),]
migration_chi_LN <- migration_chi[str_detect(migration_chi$ModelID, 'LN'),]


### HN ss
# SNP FST
migr_fst_ss = c()
for (i in 1:length(migration_fst_ss$ModelID)){
  pa = migration_fst_ss[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[2])))
  migr_fst_ss = rbind(migr_fst_ss,x)
}

migr_fst_ss <- data.frame(migr_fst_ss)
names(migr_fst_ss) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ss$power <- as.numeric(migr_fst_ss$power)
migr_fst_ss$MigrationRate <- as.numeric(migr_fst_ss$MigrationRate)
plot_title = expression(italic(F[ST - MaxSNP])~" - Migration - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_hn_ss_snp.jpg'
gg_migr_fst_ss <- heatmap_power_gg(migr_fst_ss, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ss


# window
migr_fst_ss = c()
for (i in 1:length(migration_fst_ss$ModelID)){
  pa = migration_fst_ss[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[3])))
  migr_fst_ss = rbind(migr_fst_ss,x)
}

migr_fst_ss <- data.frame(migr_fst_ss)
names(migr_fst_ss) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ss$power <- as.numeric(migr_fst_ss$power)
migr_fst_ss$MigrationRate <- as.numeric(migr_fst_ss$MigrationRate)
plot_title = expression(italic(F[ST - Window])~" - Migration - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_hn_ss_win.jpg'
gg_migr_fst_ss <- heatmap_power_gg(migr_fst_ss, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ss

# CHI
migr_chi_ss = c()
for (i in 1:length(migration_chi_ss$ModelID)){
  pa = migration_chi_ss[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[2])))
  migr_chi_ss = rbind(migr_chi_ss,x)
}

migr_chi_ss <- data.frame(migr_chi_ss)
names(migr_chi_ss) <- c('MigrationRate', 'SplitTime', 'power')
migr_chi_ss$power <- as.numeric(migr_chi_ss$power)
migr_chi_ss$MigrationRate <- as.numeric(migr_chi_ss$MigrationRate)
plot_title = expression(italic("\u03A7"[MD])~" -Migration - High"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_hn_ss_chi.jpg'
gg_migr_chi_ss <- heatmap_power_gg(migr_chi_ss, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_chi_ss


### HN ws
# SNP
migr_fst_ws = c()
for (i in 1:length(migration_fst_ws$ModelID)){
  pa = migration_fst_ws[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[2])))
  migr_fst_ws = rbind(migr_fst_ws,x)
}

migr_fst_ws <- data.frame(migr_fst_ws)
names(migr_fst_ws) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ws$power <- as.numeric(migr_fst_ws$power)
migr_fst_ws$MigrationRate <- as.numeric(migr_fst_ws$MigrationRate)
plot_title = expression(italic(F[ST - MaxSNP])~" - Migration - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'migr_hn_ws_snp.jpg'
gg_migr_fst_ws <- heatmap_power_gg(migr_fst_ws, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ws

# window
migr_fst_ws = c()
for (i in 1:length(migration_fst_ws$ModelID)){
  pa = migration_fst_ws[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[3])))
  migr_fst_ws = rbind(migr_fst_ws,x)
}

migr_fst_ws <- data.frame(migr_fst_ws)
names(migr_fst_ws) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ws$power <- as.numeric(migr_fst_ws$power)
migr_fst_ws$MigrationRate <- as.numeric(migr_fst_ws$MigrationRate)
plot_title = expression(italic(F[ST - Window])~" - Migration - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'migr_hn_ws_win.jpg'
gg_migr_fst_ws <- heatmap_power_gg(migr_fst_ws, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ws

# CHI
migr_chi_ws = c()
for (i in 1:length(migration_chi_ws$ModelID)){
  pa = migration_chi_ws[i,]
  scen = str_split_fixed(pa[1],"_",8)
  x = as.matrix(cbind(scen[6], scen[7], as.numeric(pa[2])))
  migr_chi_ws = rbind(migr_chi_ws,x)
}

migr_chi_ws <- data.frame(migr_chi_ws)
names(migr_chi_ws) <- c('MigrationRate', 'SplitTime', 'power')
migr_chi_ws$power <- as.numeric(migr_chi_ws$power)
migr_chi_ws$MigrationRate <- as.numeric(migr_chi_ws$MigrationRate)
plot_title = expression(italic("\u03A7"[MD])~" -Migration - High"~ italic(N[e])~" (s=0.001)")
plot_name = 'migr_hn_ws_chi.jpg'
gg_migr_chi_ws <- heatmap_power_gg(migr_chi_ws, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_chi_ws

### LN
# SNP
migr_fst_ln = c()
for (i in 1:length(migration_fst_LN$ModelID)){
  pa = migration_fst_LN[i,]
  scen = str_split_fixed(pa[1],"_",7)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  migr_fst_ln = rbind(migr_fst_ln,x)
}

migr_fst_ln <- data.frame(migr_fst_ln)
names(migr_fst_ln) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ln$power <- as.numeric(migr_fst_ln$power)
migr_fst_ln$MigrationRate <- as.numeric(migr_fst_ln$MigrationRate)
plot_title = expression(italic(F[ST - MaxSNP])~" - Migration - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_ln_snp.jpg'
gg_migr_fst_ln <- heatmap_power_gg(migr_fst_ln, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ln

# Window
migr_fst_ln = c()
for (i in 1:length(migration_fst_LN$ModelID)){
  pa = migration_fst_LN[i,]
  scen = str_split_fixed(pa[1],"_",7)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[3])))
  migr_fst_ln = rbind(migr_fst_ln,x)
}

migr_fst_ln <- data.frame(migr_fst_ln)
names(migr_fst_ln) <- c('MigrationRate', 'SplitTime', 'power')
migr_fst_ln$power <- as.numeric(migr_fst_ln$power)
migr_fst_ln$MigrationRate <- as.numeric(migr_fst_ln$MigrationRate)
plot_title = expression(italic(F[ST - Window])~" - Migration - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_ln_win.jpg'
gg_migr_fst_ln <- heatmap_power_gg(migr_fst_ln, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_fst_ln

# CHI
migr_chi_ln = c()
for (i in 1:length(migration_chi_LN$ModelID)){
  pa = migration_chi_LN[i,]
  scen = str_split_fixed(pa[1],"_",7)
  x = as.matrix(cbind(scen[5], scen[6], as.numeric(pa[2])))
  migr_chi_ln = rbind(migr_chi_ln,x)
}

migr_chi_ln <- data.frame(migr_chi_ln)
names(migr_chi_ln) <- c('MigrationRate', 'SplitTime', 'power')
migr_chi_ln$power <- as.numeric(migr_chi_ln$power)
migr_chi_ln$MigrationRate <- as.numeric(migr_chi_ln$MigrationRate)
plot_title = expression(italic("\u03A7"[MD])~" -Migration - Low"~ italic(N[e])~" (s=0.01)")
plot_name = 'migr_ln_chi.jpg'
gg_migr_chi_ln <- heatmap_power_gg(migr_chi_ln, 'MigrationRate', 'SplitTime', 'power', plot_title, "Migration Rate", "Split Time (coalescent units)", plot_name)
gg_migr_chi_ln
