library("seqinr") # read.fasta, rho in stats.smk
library("zoo") # rollapply
library("MASS") # ginv
# library("tidyverse") # いらない?
# library("DECIPHER") # いらない?
library("ROCR") # prediction, performance
library("ggplot2") # For Plot
library("ggbeeswarm") # For Plot

ROC <- function(score, actual){
    print("prediction")
    pred <- ROCR::prediction(score, actual)
    print("performance")
    auc <- ROCR::performance(pred, "auc")@y.values[[1]]
    nF <- sum(actual == 0)
    nT <- sum(actual == 1)
    x <- pred@fp[[1]] / nF
    y <- pred@tp[[1]] / nT
    list(auc=auc, x=x, y=y)
}

euclid_distance <- function(x, y){
  A2 <- apply(x, 1, function(xx){norm(as.matrix(xx), "F")})^2
  B2 <- apply(y, 1, function(yy){norm(as.matrix(yy), "F")})^2
  AB <- x %*% t(y)
  sqrt(outer(A2, B2, "+") - 2 * AB)
}

manhattan_distance <- function(x, y){
	apply(y, 1, function(yy, x){
    	sum(abs(x - yy))
	}, x=x)
}

delta_distance <- function(x, y, wordsize){
	t(apply_pb(x, 1, function(xx){
	    manhattan_distance(xx, y)
	}) / 4^wordsize)
}

apply_pb <- function(X, MARGIN, FUN, ...)
{
  env <- environment()
  pb_Total <- sum(dim(X)[MARGIN])
  counter <- 0
  pb <- txtProgressBar(min = 0, max = pb_Total,
                       style = 3)

  wrapper <- function(...)
  {
    curVal <- get("counter", envir = env)
    assign("counter", curVal +1 ,envir= env)
    setTxtProgressBar(get("pb", envir= env),
                           curVal +1)
    FUN(...)
  }
  res <- apply(X, MARGIN, wrapper, ...)
  close(pb)
  res
}

euclid_distance2 <- function(x, y){
	apply(y, 1, function(yy, x){
    	sqrt(sum((x - yy)^2))
	}, x=x)
}

host_matrix <- function(seqs_host, wordsize){
  Y <- rollapply(data = seqs_host[[1]],
    width = 5000, by = 5000,
    FUN = function(x){rho(c(x, ' ', rev(comp(x))), wordsize = wordsize)})
  targetY <- grep("Freq", colnames(Y))
  Y <- Y[, targetY]
}

mahalanobis_distance <- function(Y, kmer_plasmid, wordsize, reg=1E-5){
	if(is.vector(Y)){
		out <- euclid_distance2(Y, kmer_plasmid)
	}else{
		out <- mahalanobis(kmer_plasmid, center=apply(Y, 2, mean),
		    cov=ginv(var(Y) + diag(reg, ncol(Y))), inverted=TRUE)
	}
	t(out)
}
