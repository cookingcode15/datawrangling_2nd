# This is the second excercise for Data Wrangling, Dealing with Missing Values

# Set WD (hopefully this is the first step so that R can find the file.
# note i set WD under session but the path did not come up in the R script on my mac)
# i used the import dataset option to format the csv file in the evironment tab.i used readr as a package a
# and that seemed to work better than the setwd function. Is there a different way to do this? I forgot how.:
setwd("~/Desktop/SPRINGBOARD/datawrangling_2nd")

# Load the data in RStudio
titanic_original <- read.csv("titanic_original.csv")
titanic_original


# Get packages
library("readr")

library("tidyverse")

# 1: Port of embarkation, change NA values to S - there are missing values
titanic_original <- read.csv("titanic_original.csv", na.strings=c("","na")) 
# we take care of the missing values right here.

# structure
str(titanic_original)

# class - why do i call the class of this dataframe? because it tells me it is a data.frame? why is this impt?
class(titanic_original)

# embarked column changes - shows what rows are needed to change N/A
titanic_original[is.na(titanic_original$embarked),]

# Since embarked column is factor, it has to be converted into "character" first to input string.(how do i know column is a factor and not a string?)
titanic_df <- titanic_original
titanic_df$embarked <-lapply(titanic_df$embarked, as.character)

# investigate rows and columns dimensions
dim(titanic_df)[1]
dim(titanic_df)[2]
dim(titanic_df)

# check to see if it is already a data.frame
class(titanic_df)

# look at the structure
str(titanic_df)

# i forgot why we use lapply here. is there another dpylr function to use?
# library(dplyr) looked here https://www.datacamp.com/community/tutorials/15-easy-solutions-data-frame-problems-r
# Since embarked column is factor, it has to be converted into "character" first to input string.


# replace NA with "S" - how do we know to use the which function and why doesn't
# it run and shows all embarked at S now instead of replacing the NA with S. 
# I AM CONFUSED HERE...
titanic_df$embarked[which(is.na(titanic_df$embarked))] <-"S"

## return  null i.e "na" values have been replaced by "s" as required.Do we use titanic_df2 because of the subset for changing the column?
titanic_df2 <- titanic_df

# where is null and why did we create a new dataframe for null?
titanic_df2[is.na(titanic_df2$embarked),] 

# calculate the MEAN of AGE and replace with any missing values.
titanic_df2[is.na(titanic_df2$age),]

# mean of age
titanic_df2$age[which(is.na(titanic_df2$age))] <- mean(titanic_df2$age,na.rm = TRUE)

# "na" values have been replaces by mean of rest of the values
titanic_df2[is.na(titanic_df2$age),]

# return age column
titanic_df2$age

#Think about other ways you could have populated the missing values in the age column. 
# Why would you pick any of those over the mean (or not)?
# Maybe by adding another column separating gender. For those missing values, I would not guess the mean age as we would
# only work with what we have for data and take the mean age out of the total of ages we do know to get a better idea instead of just guessing.
# why is there a new dataframe here?



# 3: Lifeboat This means that there are a lot of missing values in the boat column. 
# Fill these empty slots with a dummy value e.g. the string ‘None’ or ‘NA’
# has this line of R completed this for boat column as well?
titanic_original <- read.csv("titanic_original.csv", na.strings=c("","na")) 
#how else can i do this???

# 4: Cabin
# You notice that many passengers don’t have a cabin number associated with them.
# Does it make sense to fill missing cabin numbers with a value?
# What does a missing value here mean?
# You have a hunch that the fact that the cabin number is missing might be a useful indicator of survival. 
# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

#It does not make sense to fill missing cabin numbers with a value because a missing value means 
# they might have not survived and isn't pertinent with a non value. 

#--- add cabin number if one exists, bind, then reorder columns --- how do i put this near the cabin near the has_cabin_number
titanic_df3 <- titanic_df2
titanic_df3 <- titanic_df3 %>% mutate(has_cabin_number = ifelse(!is.na(cabin),1,0))

# First coerce the data.frame to all-character
titanic_df3 = data.frame(lapply(titanic_df3, as.character), stringsAsFactors=FALSE)

# write file
write.csv(titanic_df3,"titanic_clean.csv")

#load data in rstudio
titanic_clean <- read.csv("titanic_clean.csv")



