#' @apiTitle My R Service
#' @apiDescription This service runs R scripts on Google Cloud Run.

if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#* Plumber Test
#* @get /test.png
#* @serializer contentType list(type='image/png')
function(n = 100){
  
  library(tidyverse)
  
  graph <-
    iris %>% 
    slice(1:n) %>%
    ggplot() + 
    geom_point(aes(Sepal.Length, Sepal.Width)) + 
    theme_minimal()
  
  file <- 'test.png'
  
  graph %>% 
    ggsave(filename = file)
  
  readBin(file, 'raw', n = file.info(file)$size)
}


#* Plumber Test Gif
#* @get /test.gif
#* @serializer contentType list(type='image/gif')
function(n = 100){
  
  library(tidyverse)
  library(gganimate)
  
  anim <-
    ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) + 
    geom_point() + transition_states(Species,
                                     transition_length = 2,
                                     state_length = 1) + theme_minimal() +
    ggtitle('Now showing {closest_state}',
            subtitle = 'Frame {frame} of {nframes}')
  
  file <- 'test.gif'
  
  anim %>%
    anim_save(filename = file)
  
  readBin(file, 'raw', n = file.info(file)$size)
}




#* @get /
#* @html
function(){
  "<html><h1>It works!</h1></html>"
}


