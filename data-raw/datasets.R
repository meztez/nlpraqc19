
collisions <- readRDS("../lab/dtsin20181218.rds")
collisions <- collisions[, .(QUEST_CICH_COMNT, QUEST_COLLISION_PERTETOT)]
collisions <- collisions[sample(1:nrow(collisions), 100000)]

title <- content %>% html_nodes('a.storylink') %>% html_text()



usethis::use_data(collisions, internal = FALSE, overwrite = TRUE)



library(rvest)
content <- read_html('https://old.reddit.com/r/Quebec/')
submissions <- content %>% html_nodes('a.title') %>% html_text
links <- content %>% html_nodes('a.title') %>% html_attr("href")
rqclatest <- data.frame("submissions" = submissions, "links" = links)
View(rqclatest)

# References
# https://datascienceplus.com/building-a-hacker-news-scraper-with-8-lines-of-r-code-using-rvest-library/
# https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html


# •	Manipuler des chaînes de caractères.
# •	Explorer une liste de documents.
# •	Corriger les erreurs d’orthographe et extraire les racines des mots.
# •	Identifier les contextes négatifs en utilisant des collocations.
# •	Calculer la matrice de fréquence des termes dans des documents.
# •	Explorer l’utilité des plongements avec des vecteurs globaux pour la représentation de mots.
# •	Transformer une liste de documents en attributs pour l’apprentissage machine.
