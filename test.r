success <- 0:50
plot(success,dbinom(success,size=50,prob=.45),
     type='h',
     main='Binomial Distribution (n=50, p=0.45)',
     ylab='Probability',
     xlab ='Successes',
     lwd=3)