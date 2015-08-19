set.seed(955)


######################
# Defining Functions #
######################

wssplot <- function(some_mat, nc=50, seed=1234, heading = 'wssplot'){
wss <- (nrow(some_mat)-1)*sum(apply(some_mat,2,var))
for (i in 2:nc){
set.seed(seed)
wss[i] <- sum(kmeans(some_mat, centers=i)$withinss)} # Using MacQueen for small sets # ,algorithm = 'Lloyd'
plot(1:nc, wss, type="b", xlab="Number of Clusters",
   ylab="Within groups sum of squares", main = heading)}


# Reading data

data <- read.table('/home/seth/Downloads/Lecture 5 Cluster Analysis/M5/zipdata.txt', sep = ',', head = TRUE)

data <- data[2:length(data),]

##########################
# Hirarchical clustering #
##########################

distance <- dist(data)

clusterComplete <- hclust(distance)

clusterWard <- hclust(distance, method = 'ward.D')

#pdf('clustering.pdf')

#plot(clusterComplete)
#plot(clusterWard)

#dev.off()


##################
# Gap statistics #
##################


wssplot(data, nc = 20)

gaps <- clusGap(data, kmeans, 20, B = 100, verbose = interactive())
plot(gaps)

gapFinal <- maxSE(gaps$Tab[,'gap'], gaps$Tab[,'SE.sim'], method = "Tibs2001SEmax")

paste0('Optimal number of clusters: ', gapFinal)

# maxSE(gaps$Tab[,'gap'], gaps$Tab[,'SE.sim'])