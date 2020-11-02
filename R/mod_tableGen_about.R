#' tableGen_about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tableGen_about_ui <- function(id) {
  ns <- NS(id)
  tagList(
    br(),br(),br(),
    wellPanel(
      style="padding:20px;width:75%;margin:auto;",
      h1("How it Works"),
      fluidRow(
        column(4,
                br(), br(),
         p(
         style="font-size:15px;",
         "
         Clinical trial data that follows the", a("CDISC", href="https://www.cdisc.org/"), "standard
         share common column names that are used as keys to merge the data collected
         over the course of a study.
         ",
                br(), br(),
                "By leveraging this common data structure 
         and the summary statistic patterns seen in clinical submissions,
         we've created a custom shiny input that generates a {gt} table
         by dragging pairs of columns and their summary statistic counterpart.",
                br(), br(),
                "Each file the user uploads into the application creates a dropdown of blocks corresponding to column names. 
         These columns can be pared with either numeric (mean, chg, anova) or categorical (freq) summary blocks to create a table.
         ",
                br(), br(),
                "The data can be filtered using our filter dropdown, 
         and we even have a dropdown of commonly created tables --
         rather than drag in all the block pairs needed for a demographic table,
         you can select 'DEMOGRAPHY' from the dropdown."
        )
        ),
      column(8,
             img(src="www/tablecomp.gif", style="width:90%;margin:auto;padding:50px;filter:drop-shadow(0 0 0.75rem gray);")
             )
      ))
    )
}
 
