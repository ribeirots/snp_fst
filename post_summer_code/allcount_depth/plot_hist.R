setwd('/home/tiago/Dropbox/Pool/Summer2020/ms_tiago/allcount_depth/')
#setwd('/media/tiago/Seagate Portable Drive/fas1k/')
library(ggplot2)

rm(list=ls())

filename = 'AllCounts_FR_Chr3R_diploids_cov.csv'
n.data <- read.csv(filename)
for(ntmp in n.data[1]) { n <- ntmp}
class(n)
names(n.data) <- 'X0'
probs <- c(0.1)
quant <- quantile(n, prob=probs, names=F)

plot_title = paste('FR','2L')
pic_name = paste('histogram_','FR','_','3L','.jpg',sep='')
print(pic_name)
hist_depth <- ggplot(n.data, aes(X0)) + geom_histogram(binwidth=1, colour="black", fill="white") + geom_vline(xintercept = quant, color="red", linetype="dashed", size=1) + scale_x_continuous(breaks=quant) + xlab('Sample Size') + ggtitle(plot_title)
hist_depth # 2L: 0.12 perc, thresh = 87. 2R: 0.13 perc, thresh = 101.  3L: 0.105 perc, thresh = 86. 3R: 0.1 perc, thresh = 63. X: 0.15 perc, thresh = 89.
ggsave(filename = pic_name, hist_depth, width=4,  height=3.5)



filename = paste('~/Dropbox/Pool/Summer2020/ms_tiago/allcount_depth/samplesize_allcounts_', 'ZI','_', 'ChrX','.csv',sep='')
n.data <- read.csv(filename)
for(ntmp in n.data[1]) { n <- ntmp}
class(n)
names(n.data) <- 'X0'
probs <- c(0.18)
quant <- quantile(n, prob=probs, names=F)

plot_title = paste('ZI','X')
pic_name = paste('histogram_','ZI','_','X','.jpg',sep='')
print(pic_name)

hist_depth <- ggplot(n.data, aes(X0)) + geom_histogram(binwidth=1, colour="black", fill="white") + geom_vline(xintercept = quant, color="red", linetype="dashed", size=1) + scale_x_continuous(breaks=quant) + xlab('Sample Size') + ggtitle(plot_title)
hist_depth # 2L: 0.175 percentile - thresh = 143. 2R: 0.175 percentile - thresh = 158. 3L: 0.175 percentile - thresh = 151. 3R: 0.14 percentile - thresh = 129. X: 0.18 percentile - thresh = 181.
ggsave(filename = pic_name, hist_depth, width=4,  height=3.5)






for(pop in c('CO','EA','EF','EG','FR','RG','SD','ZI','KF')){
  for(chrm in c('ChrX','Chr2L','Chr2R','Chr3L','Chr3R')){
#    pop = 'RG'
#    chrm = 'Chr3L'
    filename = paste('samplesize_allcounts_', pop,'_', chrm,'.csv',sep='')
    n.data <- read.csv(filename)
    
    for(ntmp in n.data[1]) { n <- ntmp}
    
    class(n)
    probs <- c(0.1)
    quant <- quantile(n, prob=probs, names=F)
    
    plot_title = paste(pop,chrm)
    pic_name = paste('histogram_',pop,'_',chrm,'.jpg',sep='')
    print(pic_name)
    
    hist_depth <- ggplot(n.data, aes(X0)) + geom_histogram(binwidth=1, colour="black", fill="white") + geom_vline(xintercept = quant, color="red", linetype="dashed", size=1) + scale_x_continuous(breaks=quant) + xlab('Sample Size') + ggtitle(plot_title)
    hist_depth
    ggsave(filename = pic_name, hist_depth, width=4,  height=3.5)
    
  }
  
}



setwd('/home/tiago/Dropbox/Pool/Summer2020/ms_tiago/allcount_depth//')

pop='FR'
chrm='Chr2R'

file2 <- paste('samplesize_allcounts_', pop,'_', chrm,'.csv',sep='')
noinv.data <- read.csv(file2, sep = '\t')
noinv.data$sum = rowSums(noinv.data)
summary(noinv.data$sum)


probs <- c(0.25)
quant <- quantile(noinv.data$sum, prob=probs, names=F)

plot_title = paste(pop,chrm)
hist_depth <- ggplot(noinv.data, aes(sum)) + geom_histogram(binwidth=1, colour="black", fill="white") + geom_vline(xintercept = quant, color="red", linetype="dashed", size=1) + scale_x_continuous(breaks=quant) + xlab('Sample Size') + ggtitle(plot_title)
hist_depth

