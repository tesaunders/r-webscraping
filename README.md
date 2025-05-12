# R webscraping tutorial

A quick introduction to webscraping in R using {rvest} with a couple of use cases relevant for researchers. 

## R scripts

- `scrape-wiki.R` shows an example of scraping multiple tables from a website (in this case Wikipedia) and joining them together based on a column with common values.
- `scrape-carjam.R` shows an example of scraping tables from multiple webpages using an offset in the URL.
- `scrape-imdb.R` shows an example of scraping a single table weekly, and using a GitHub action to automate this process (in `.github/workflows/update.yml`), in order to build a dataset to show changes over time.

Data scraped from the IMDB example is saved in `/data`, and `analyse.R` can be used to analyse and plot the data to show changes over time.

## Other files

- `slides.qmd` is a Quarto markdown document containing code used to create slides in the `/docs` directory, based ona couple of options in `_quarto.yml`, which are then [published here](https://tesaunders.github.io/scraping-tutorial/) via GitHub pages.
- `r-scraping-tutorial.Rproj` is an RStudio project file and `.gitignore` is created by RStudio to exclude certain files from being tracked by version control.
- `.nojekyll` tells GitHub pages not to do any further processing to the 'website' used to host the slides.

## Licence

All code in this repository is licensed under the MIT license.
