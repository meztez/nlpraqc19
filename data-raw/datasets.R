library("data.table")
load("../data/collisions.rda")
collisions <- collisions[, .(QUEST_CICH_COMNT, QUEST_COLLISION_PERTETOT)]
collisions <- collisions[sample(1:nrow(collisions), 100000)]
usethis::use_data(collisions, internal = FALSE, overwrite = TRUE)
