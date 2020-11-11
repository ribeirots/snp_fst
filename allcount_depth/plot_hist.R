setwd('Dropbox/Pool/Summer2020/ms_tiago/allcount_depth/')
library(ggplot2)


for(pop in c('CO','EA','EF','EG','FR','RG','SD','ZI','KF')){
  for(chrm in c('ChrX','Chr2L','Chr2R','Chr3L','Chr3R')){
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
    ggsave(filename = pic_name, hist_depth, width=4,  height=3.5)
    
  }
  
}

pop='CO'
chrm='Chr3R'
