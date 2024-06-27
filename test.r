library(tidyverse)

#starwars dataset
view(starwars)
glimpse(starwars)

fat_characters <- filter(starwars, mass > 100)
view(fat_characters)

view(filter(starwars, films == 'A New Hope'))

ggplot(starwars, aes(x = mass)) +
    geom_histogram() +
    geom_freqpoly()

#mpg dataset
view(mpg)
glimpse(mpg)

view(filter(mpg, manufacturer == 'ford'))

ggplot(mpg, aes(x = cty)) +
    geom_histogram() +
    geom_freqpoly()

ggplot(mpg, aes(x = cty, y = hwy, color = class)) +
    geom_point()