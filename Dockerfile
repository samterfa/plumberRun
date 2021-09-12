FROM rocker/tidyverse

# RUN install2.r plumber  # Add more packages separated by spaces.

RUN installGithub.r rstudio/plumber # Uncomment to add Github packages.

COPY [".", "./"]

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(rev(commandArgs())[1]); pr$run(host='0.0.0.0', port=8000)"]

CMD ["Plumber.R"]
