# Loading packages
library(tidyverse)
library(tidytuesdayR)
library(showtext)
library(glue)
library(ggtext)
library(magick)
library(grid)	

# Loading dataset 
tuesdata <- tidytuesdayR::tt_load(2023, week = 33)
spam_data <- tuesdata$spam %>% rename(`capital characters` = 1,
         spam = 7) 

# Loading fonts and colors
font_add('fa-reg', 'c:/Users/info/OneDrive/Dokumente/fonts/Font Awesome 6 Free-Regular-400.otf')
font_add('fa-brands', 'c:/Users/info/OneDrive/Dokumente/fonts/Font Awesome 6 Brands-Regular-400.otf')
font_add('fa-solid', 'c:/Users/info/OneDrive/Dokumente/fonts/Font Awesome 6 Free-Solid-900.otf')
font_add_google("Permanent Marker", "pm")
showtext_auto()
bg <- "lightblue"
col1 <- thematic::okabe_ito()[1]
col2 <- thematic::okabe_ito()[2]
col3 <- thematic::okabe_ito()[3]
col4 <- thematic::okabe_ito()[4]
col5 <- thematic::okabe_ito()[5]

# text creation
twitter <- glue("<span style='color:{col1};font-family:fa-brands;'>&#xf099;</span>")
mastodon <- glue("<span style='color:{col1};font-family:fa-brands;'>&#xf4f6;</span>")
link <- glue("<span style='color:{col1};font-family:fa-solid;'>&#xf0c1;</span>")
data <- glue("<span style='color:{col1};font-family:fa-solid;'>&#xf1c0;</span>")
hash <- glue("<span style='color:{col1};font-family:fa-solid;'>&#x23;</span>")
space <- glue("<span style='color:{bg}'>-</span>")
space2 <- glue("<span style='color:{bg}'>--</span>") # can't believe I'm doing this

bang <- glue("<span style='color:{col1}'><b>bang</b></span>")
dollar <- glue("<span style='color:{col2}'><b>dollar</b></span>")
make <- glue("<span style='color:{col3}'><b>make</b></span>")
money <- glue("<span style='color:{col4}'><b>money</b></span>")
n.000 <- glue("<span style='color:{col5}'><b>n000</b></span>")

t <- "<b>Email Words and Spam</b>" 
s <- glue("Tidy Tuesday 2023 | Week 32 | strings: {bang}, {dollar}, {make}, {money} and {n.000}") 
cap <- glue("{twitter}{space2}@web_design_fh{space2} 
	{space2}{mastodon}{space2}@frankhaenel @fosstodon.org{space2}
	{space2}{link}{space}{space2}www.frankhaenel.de<br>
	{data}{space2}Rdatasets{space2}package{space2}
	{space2}{hash}{space2}tidytuesday")

# plot creation

spam_data %>%
  pivot_longer(cols = c(1:6), names_to = "feature") %>%
  filter(feature != "capital characters") %>%
  ggplot(aes(value, spam, color = feature, fill = feature)) +
  geom_boxplot(show.legend = F, alpha = 0.5) +
  facet_wrap(~feature, scales = "free_x") +
  scale_x_log10() +
  theme_minimal() + 
  theme(strip.text = element_blank(),
  panel.background = element_rect(fill=bg),
  plot.background = element_rect(fill=bg),
  plot.title = element_markdown(hjust = 0, lineheight = 1.3),
  plot.subtitle = element_markdown(hjust = 0, lineheight = 1.3),
  plot.caption = element_markdown(hjust = 0, lineheight = 1.3)) + 
  scale_fill_manual(values = thematic::okabe_ito()[1:5]) + 
  scale_color_manual(values = thematic::okabe_ito()[1:5]) + 
  labs(title = t, subtitle = s, caption = cap)
  logo <- image_read("C:/Users/info/OneDrive/Dokumente/spam.png")
  grid::grid.raster(logo, x = 0.9, y = 0.1, just = c('right', 'bottom'), width = unit(2.5, 'inches'))
  
