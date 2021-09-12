#' @apiTitle My R Service
#' @apiDescription This service runs R scripts on Google Cloud Run.

if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#* Plumber Test
#* @get /test
#* @serializer contentType list(type='image/png')
function(n = 100){
  
  library(tidyverse)
  
  graph <-
    iris %>% 
    head(n) %>%
    ggplot() + 
    geom_point(aes(Sepal.Length, Sepal.Width)) + 
    theme_minimal()
  
  file <- 'test.png'
  
  graph %>% 
    ggsave(filename = file)
  
  readBin(file, 'raw', n = file.info(file)$size)
}
