server <- function(input, output) {
  options(shiny.maxRequestSize=2*30*1024^2)
  source_python('audio2text.py')
  
  output$contents <- renderTable({
    
    req(input$file1)
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    tryCatch(
      {
        
        #speech2text('audio-lezione.mp4')
        
        a <- speech2text(input$file1$datapath,input$lan)
        
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
  })
}