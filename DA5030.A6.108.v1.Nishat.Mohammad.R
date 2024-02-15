## Practice / Generate Synthetic Data  ####
# Author: Nishat Mohammad 
# date: 01/19/2024

## Tasks  ####
### Question 1. ####
#Load the CSV teams.csv into a data frame. This CSV contains names of teams for the league. They are fictitious and were originally created by a generative AI agent. Inspect the data frame and the CSV file to ensure it has been loaded properly. Consider creating a smaller version of the file that has only four teams; it is easier to debug that way – the use of abbreviated data files is common during development.
#### Answers ####

url = "http://artificium.us/assignments/06.r/a-6-108/teams.csv"
schedule_df <- read.csv(url)
str(schedule_df)


### Question 2. ####
#Create an empty data frame that has the columns you need.
#### Answers ####

names<- c("home.team","away.team","home.team.goals","away.team.goals","ot")
empty_df <- data.frame(matrix(ncol = 5, nrow = 0))
colnames(empty_df) <- names
empty_df


### Question 3. ####
#Start by generating a game schedule where each team plays the other; then add to that schedule the same but home and away teams are reverse. After that you will have a game schedule where each team plays the other twice.
#### Answers ####
# Get the values of home team and away teams using first 4 teams in the given data
hm_team <- c(schedule_df$team.name[1:4])
hm_team2 <- c(hm_team[2:4], hm_team[1])
hm_team3 <- c(hm_team2[2:4], hm_team2[1])
hm_team4 <- c(hm_team3[2:4], hm_team3[1])
hm_team4
home.team <- rep(hm_team, time = 3)
away.team <- c(hm_team2, hm_team3, hm_team4)

home.team.goals <- c("")
away.team.goals <- c("")
ot <- c("")

sub_df <- cbind(home.team, away.team,home.team.goals,away.team.goals, ot )
sub_df

empty_df
my_teams_df <- rbind(empty_df,sub_df)
my_teams_df

### Question 4. ####
#Generate scores for each team (perhaps use the random number generator function runif() which generates a random uniformly distributed number from a range). If the score is tied, set the “ot” flag and then randomly give an extra goal to one of the two teams to simulate an overtime win.
#### Answers ####
# Get the scores add to the df
?runif
set.seed(786)
home.team.goals <- round(runif(n=nrow(my_teams_df), min=0, max = 7),0)
my_teams_df$home.team.goals <- home.team.goals
my_teams_df
away.team.goals <- round(runif(n=nrow(my_teams_df), min = 0, max = 7 ),0)
my_teams_df$away.team.goals <- away.team.goals
my_teams_df

# Get the tie games
tie_game <- (my_teams_df$home.team.goals == my_teams_df$away.team.goals)
tie_game
my_teams_df$ot <- tie_game
my_teams_df

# add an extra score to any team in tie games
for (i in my_teams_df$ot ){
  if (i==TRUE){
    my_teams_df$home.team.goals<- home.team.goals + 1
  } 
}
my_teams_df

### Question 5. ####
#Once all the game data has been generated, save the file as a CSV under the name “gameschedule.csv”.
#### Answers ####
write.csv(my_teams_df,"gameschedule.csv", row.names = FALSE)
