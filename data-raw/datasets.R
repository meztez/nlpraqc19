
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




Pour utiliser hunspell, il faut d'abord un ou des dictionnaires.
Dans cet exemple, on va utiliser un dictionnaire français et un dictionnaire canadien français.
On va également ajouter des mots spécifiques au contexte.

On peut extraires les dictionnaires directement des extensions de Firefox avec une fonction personnalisée.  
```{r extractdict, echo = FALSE}
extractdict <- function(url) {
  temp <- tempfile()
  curl::curl_download(url, temp)
  dicts <- grep("\\.aff?|\\.dic?", unzip(temp, list = TRUE)$Name, value = TRUE)
  unzip(temp, files = dicts, overwrite = TRUE, junkpaths = TRUE, exdir = "data-raw")
  unlink(temp)
  return(paste0("./data-raw/", basename(grep("\\.dic", dicts, value = TRUE))))
}

dict_fr <- extractdict("https://addons.mozilla.org/firefox/downloads/file/1163947/french_spelling_dictionary-6.3.1webext.xpi")
dict_en <- extractdict("https://addons.mozilla.org/firefox/downloads/file/1163920/canadian_english_dictionary-3.0.6.1webext.xpi")
```

Maintenant on peut combiner les dictionnaires et ajouter des mots.  
```{r dict, echo = FALSE}
added_words <- c("b2","b3","tp","vh","boul","v\U00e9h","faq","vt","faq20",
                 "veh","mtl","43a","qc","rdp","dir","43ae","cond","domms",
                 "20a","iga","aut","ins","ste","st","blv","domm","pcq","bags",
                 "43e","rp","coord","faq43a","berpa","13c","faq27","str")

dict <- dictionary(c(dict_fr, dict_en), add_words = added_words)
```


```{r autocorrect, echo=FALSE}
autocorrect <- function(txt, dict) {
  parsed <- hunspell_parse(txt, dict = dict)
  checked <- lapply(parsed, hunspell_check, dict = dict)
  suggested <- lapply(1:length(parsed), function(i) {
    if (!all(checked[[i]])) {
      suggested <- unlist(lapply(hunspell_suggest(parsed[[i]][!checked[[i]]], dict = dict), `[`, 1))
      parsed[[i]][!checked[[i]]] <- ifelse(is.na(suggested), parsed[[i]][!checked[[i]]], suggested)
    }
    stemmed <- unlist(lapply(hunspell_stem(parsed[[i]], dict = dict), `[`, 1))
    return(ifelse(is.na(stemmed), parsed[[i]], stemmed))
  })
  return(unlist(lapply(suggested, paste, collapse = " ")))
}

autocorrect <- function(txt, dict) {
  vocab <- create_vocabulary(itoken(txt))
  setDT(vocab)
  vocab[, misspelled := !hunspell_check(term, dict = dict)]
  vocab[misspelled == TRUE, suggested := unlist(lapply(hunspell_suggest(term, dict = dict), `[`, 1))]
  checked <- lapply(parsed, hunspell_check, dict = dict)
  suggested <- lapply(1:length(parsed), function(i) {
    if (!all(checked[[i]])) {
      suggested <- unlist(lapply(hunspell_suggest(parsed[[i]][!checked[[i]]], dict = dict), `[`, 1))
      parsed[[i]][!checked[[i]]] <- ifelse(is.na(suggested), parsed[[i]][!checked[[i]]], suggested)
    }
    stemmed <- unlist(lapply(hunspell_stem(parsed[[i]], dict = dict), `[`, 1))
    return(ifelse(is.na(stemmed), parsed[[i]], stemmed))
  })
  return(unlist(lapply(suggested, paste, collapse = " ")))
}
```