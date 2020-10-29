#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#' 
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  observeEvent(input$myBrowser , {
    if(str_detect(input$myBrowser, "IE")){
      showModal(tags$div(id="browserModal", modalDialog(footer = NULL,
                                                        glue("This web app doesn't function with Internet Explorer. Please use a modern browser such as Google Chrome.")
      )))
    }    
  })
  
  # CDISC pilot data
  datafile <-  reactive({
    list(
    ADSL = adsl,
    ADVS = advs,
    ADAE = adae,
    ADLBC = adlbc
    )
  })
  
  # render the tablegenerator module using the datafile from dataupload as an input
  table_generator <- callModule(mod_tableGen_server, "tableGen_ui_1", datafile = datafile)
  output$all_rows <- renderUI({ table_generator() })

}
