#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#' 
#' @import shiny
#' @noRd
app_ui <- function(request) {
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # List the first level UI elements here 
    navbarPage(title = div(id="logo-id","RStudio Table Contest Submission"), 
               id = "navbarID",
               windowTitle = "tidyCDISC",
               tabPanel(
                 title = "About",
                 mod_tableGen_about_ui("tableGen_about_ui_1")
               ),
               tabPanel(
                 title = "Table Generator",
                 div(mod_tableGen_ui("tableGen_ui_1"), id = "tableGen")
               ),
               tags$script(
                 HTML("var header = $('.navbar > .container-fluid');
                              header.append('<img src=\"www/biogen-logo.png\" style=\"width:5%;height:5%;float:right;padding-top:7px;\">')")
               ),
               tags$script(
                 HTML("var header = $('.navbar > .container-fluid');
                              header.append('<a href=\"https://github.com/biogen-inc\" target=\"_blank\"><img id=\"github\" src=\"www/github.png\" style=\"float:right;padding-top:5px;padding-right:15px;\"></a>')")
               ))
    )
  }

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @importFrom shinyjs useShinyjs
#' @importFrom shinyjs extendShinyjs
#' @importFrom shinyjs inlineCSS
#' @importFrom cicerone use_cicerone
#' @noRd
golem_add_external_resources <- function(){
  
  # source("R/global.R")
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  # golem tags$head start
  tags$head(
    
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'tidyCDISC'
    ),
    
    tags$script(HTML(htmljs)),
    tags$script(src = "https://code.jquery.com/ui/1.12.1/jquery-ui.js"),
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(css),
    shinyjs::extendShinyjs(text = jscode),
    cicerone::use_cicerone()
  )

}