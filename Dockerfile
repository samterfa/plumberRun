FROM rocker/tidyverse

RUN install2.r gganimate gifski # Add more packages separated by spaces.

RUN installGithub.r rstudio/plumber # Github packages.

COPY [".", "./"]

EXPOSE 8000 80 443

ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(rev(commandArgs())[1]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]

CMD ["Plumber.R"]
