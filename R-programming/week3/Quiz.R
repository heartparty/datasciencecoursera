pollutantmean<- function(directory, pollutant = "sulfate", id = 1:332) {
  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  # initialize a vector to hold the pollutant data
  mean_vector <- c()
  
  # find all files in the specdata folder
  all_files <- as.character(list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  for(i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")    
    na_removed <- current_file[!is.na(current_file[, pollutant]), pollutant]
    mean_vector <- c(mean_vector, na_removed)
  }
  result <- mean(mean_vector)
  return(round(result, 3)) 
}



complete <- function(directory, id = 1:332) {
  
  # set working directory
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  
  # get the length of id vector
  id_len <- length(id)
  complete_data <- rep(0, id_len)
  
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  j <- 1 
  
  for (i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")
    complete_data[j] <- sum(complete.cases(current_file))
    j <- j + 1
  }
  result <- data.frame(id = id, nobs = complete_data)
  return(result)
} 





corr <- function(directory, threshold = 0) {

  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  # get the complete table
  complete_table <- complete("specdata", 1:332)
  nobs <- complete_table$nobs
  # find the valid ids
  ids <- complete_table$id[nobs > threshold]
  # get the length of ids vector
  id_len <- length(ids)
  corr_vector <- rep(0, id_len)
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  j <- 1
  for(i in ids) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")
    corr_vector[j] <- cor(current_file$sulfate, current_file$nitrate, use="complete.obs")
    j <- j + 1
  }
  result <- corr_vector
  return(result)   
}

