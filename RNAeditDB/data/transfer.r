EncodingSeq <- function(sequence){
  A <- "10000"
  C <- "01000"
  G <- "00100"
  T <- "00010"
  N <- "00001"
  encoded_seq <- lapply(sequence,function(x){
    x <- toupper(x)
    x <- gsub("A",A,x)
    x <- gsub("C",C,x)
    x <- gsub("G",G,x)
    x <- gsub("T",T,x)
    x <- gsub("N",N,x)
  })
  encoded_seq <- unlist(encoded_seq)
  return(encoded_seq)
}

convStringToMatrix <- function(encodedSeqs, seq_len=100){
  # ensure the character type of encodedSeqs
  encodedSeqs <- as.character(encodedSeqs)
  # create the feature matrix:
  x_array <- array(data = 0, dim = c(5,seq_len, length(encodedSeqs)))
  s <- 1 # sequence/instance index
  r <- 1 # row of the matrix, each row represents A,T/U, G, C
  c <- 1 # column of the matrix, each column represents each nucleotide in the 200nt sequence
  j <- 1 # index of character in the one-hot encoded string
  # store each character into the right place of 3D matrix
  while (s <= length(encodedSeqs)) {
    c <- 1
    while (c <= seq_len) {
      r <- 1
      while (r <= 5) {
        x_array[r,c,s] <- as.integer(substr(encodedSeqs[s], j,j))
        r <- r + 1
        j <- j + 1
      }
      c <- c + 1
    }
    s <- s + 1
    j <- 1
  }
  
  #change the index order of x_array to the one keras package required:
  x_array_new <- aperm(x_array,c(3,2,1))
  return(x_array_new)
}