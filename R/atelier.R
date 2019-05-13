#' @importFrom tm removeWords stopwords
clean_text <- function(txt) {
  # txt <- tolower(txt)
  # # identifier contexte negatif par remplacement par un seul identifiant
  # neg <- c(
  #   "aren't", "aucn", "aucun", "aucune", "can't", "cannot", "couldn't", "didn't",
  #   "doesn't", "don't", "hadn't", "hasn't", "haven't", "isn't", "mustn't", "ni",
  #   "no", "non", "none", "not", "pas", "persone de", "sans", "shan't", "shouldn't",
  #   "wasn't", "weren't", "won't", "wouldn't"
  # )
  # txt <- gsub(paste0("\\b", neg, "\\b", collapse = "|"), "negctxt", txt)
  # # enlever les mots poches, les stopwords
  # swe <- tm::stopwords("en")
  # swf <- tm::stopwords("fr")
  # txt <- tm::removeWords(txt, c(swe, swf))
  # # enlever les accents avec le code unicode pour etre platform independant
  # o1 <- "\U0073\U007a\U00fe\U00e0\U00e1\U00e2\U00e3\U00e4\U00e5\U00e7\U00e8\U00e9\U00ea\U00eb\U00ec\U00ed\U00ee\U00ef\U00f0\U00f1\U00f2\U00f3\U00f4\U00f5\U00f6\U00f9\U00fa\U00fb\U00fc\U00fd"
  # n1 <- "szyaaaaaaceeeeiiiidnooooouuuuy"
  # txt <- chartr(o1, n1, txt)
  # # enlever ce qui est pas a-z
  # txt <- gsub("[[:punct:]]|[^[:graph:]]|[0-9]+", " ", txt)
  # txt <- gsub("[ ]+", " ", txt)
  # return(txt)
  
  # Créer votre propre fonction de nettoyage
}

#' @importFrom xgboost xgb.DMatrix
#' @importFrom text2vec Collocations itoken word_tokenizer create_dtm
prepare <- function(input, ...) {

  # # Prepare comments text analyse
  # it <- text2vec::itoken(input,
  #              preprocessor = clean_text,
  #              tokenizer = word_tokenizer)
  # inputtm <- text2vec::create_dtm(syntcolloc$transform(it), bvtz)
  
  # Créer votre propre fonction de préparation 

  inputtm@Dimnames[[2]] <- paste0("VOCABULAIRE_",toupper(inputtm@Dimnames[[2]]))

  return(inputtm)
}