library(shiny)
library(reticulate)

use_python("/usr/local/lib/python3.6")
# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Audio 2 Text"),


tagList(tags$hr(),
tags$h4("Upload an audio file to convert it to text"),
          tags$p("The service uses Google's speech recognition APIs but, unlike Google, this service has no time limits. Funny, isn't it?"),
          tags$p("Some files can take few minutes (2h ~ 20minutes)"),
tags$p("No file will be stored, just processed on RAM")
),
  
#sidebarLayout(
    # Sidebar panel for inputs ----
#    mainPanel(

#h3("Upload an audio file to convert it to text"),
#        p("The service uses Google's speech recognition APIs but, unlike Google, this service has no time limits./n Funny, isn't it?")
#        p("Some files can take few minutes (2h ~ 20minutes"),
#)),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
sidebarPanel(
      # Input: Select a file ----
      fileInput("file1", "Choose File",
                multiple = FALSE,
                #  accept = c("text/csv","text/comma-separated-values,text/plain",".csv")
      ),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Checkbox if file has header ----
      # checkboxInput("header", "Header", TRUE),
      # 
      # Input: Select separator ----
      radioButtons("lan", "Language",
                   choices = c("Italian" = "it-it",
                               "English UK" = "en-GB",
                               "English USA" = "en-US",
                               "Spanish" = "es-ES"),
                   selected = "it-it"),
      # 
      # # Input: Select quotes ----
      # radioButtons("quote", "Quote",
      #              choices = c(None = "",
      #                          "Double Quote" = '"',
      #                          "Single Quote" = "'"),
      #              selected = '"'),
      # 
      # # Horizontal line ----
      # tags$hr(),
      # 
      # # Input: Select number of rows to display ----
      # radioButtons("disp", "Display",
      #              choices = c(Head = "head",
      #                          All = "all"),
      #              selected = "head")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Data file ----
      tableOutput("contents")
      
    )
    
  ),
tags$div(
  HTML('
&nbsp;
<hr />
<p style="text-align: center;">A work by <a href="http://matteolocatelli.com/">Matteo Locatelli</a></p>

<!-- Add icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Add font awesome icons -->
<p style="text-align: center;">
    <a href="https://www.linkedin.com/in/matteo-locatelli-25936639/" class="fa fa-linkedin"></a>
</p>

&nbsp;
')
)
)
