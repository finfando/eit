library(ggplot2)
setwd("C:\\Users\\Filip\\gitrepos\\eit\\intelligent_data_analysis\\assignment_1")
load('movies.RData')
colnames(movies)
nrow(movies)

# calculate new variable thtr_dvd_rel_diff_days (integer)
movies$thtr_rel_date<-as.Date(paste(movies$thtr_rel_year,movies$thtr_rel_month,movies$thtr_rel_day, sep='-'))
movies$dvd_rel_date<-as.Date(paste(movies$dvd_rel_year,movies$dvd_rel_month,movies$dvd_rel_day, sep='-'))
movies$thtr_dvd_rel_diff<-movies$dvd_rel_date-movies$thtr_rel_date
movies$thtr_dvd_rel_diff_days<-as.integer(movies$dvd_rel_date-movies$thtr_rel_date)

# genre
movies$genre_enc <- movies$genre
movies$genre_enc[movies$genre=='Animation'] <- 'Other'
movies$genre_enc[movies$genre=='Art House & International'] <- 'Other'
movies$genre_enc[movies$genre=='Musical & Performing Arts'] <- 'Other'
movies$genre_enc[movies$genre=='Science Fiction & Fantasy'] <- 'Other'

# basic stats
head(movies)
summary(movies$thtr_dvd_rel_diff_days)
hist(movies$thtr_dvd_rel_diff_days)

# Explore wierd individual observations
# movies with missing dvd release date
movies[is.na(movies$thtr_dvd_rel_diff_days),1:3]
# movies with dvd released earlier than theater
movies[(movies$thtr_dvd_rel_diff_days)<=0 & !is.na(movies$thtr_dvd_rel_diff_days),]
# movies with dvd released earlier than 1997
movies[(movies$dvd_rel_year)<1997 & !is.na(movies$thtr_dvd_rel_diff_days),]

# First movies on DVDs were released in 1997
plot <- (
  ggplot(
    data=movies, 
    aes(
      x=dvd_rel_year)
  )
  +geom_bar()
  +ylab('Number of movies')
  +xlab('DVD Release Year')
)
print(plot)

plot <- (
  ggplot(data=movies)
  +stat_summary(
    aes(x=thtr_rel_year, y=thtr_dvd_rel_diff_days),
    fun.y=median,
    geom='bar'
  )
  +ylab('Median number of days until DVD release')
  +xlab('Theater Release Year')
)
print(plot)

# from now on we consider only movies released after 1997
movies_clean = movies[
  movies$thtr_rel_year>=1997
  & !is.na(movies$thtr_dvd_rel_diff_days)
  & movies$thtr_dvd_rel_diff_days >= 0
  ,]
summary(movies_clean$thtr_dvd_rel_diff_days)
hist(movies_clean$thtr_dvd_rel_diff_days)

# Q1_P2
plot <- (
  ggplot(
    data=movies_clean, 
    aes(
      x=genre_enc, 
      y=log(thtr_dvd_rel_diff_days),
      col=genre_enc
      )
    )
  +geom_boxplot()
  #+ylim(0,750)
  +ylab('Log number of days from theater release to dvd release')
  +xlab('Genre (grouped)')
  )
print(plot)

plot <- (
  ggplot(data=movies_clean, aes(x=critics_score, y=log(thtr_dvd_rel_diff_days)))
  +geom_point()
  #+geom_smooth()
  +ylab('Log number of days from theater release to dvd release (log)')
  #+ylim(0,750)
  +xlab('Critic\'s score')

)
print(plot)