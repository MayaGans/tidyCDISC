#' Generate summary statistics 
#' using table generator blocks
#'
#' @param column the variable to perform summary statistics on,
#' this also contains the class of the column
#' based on the data file the column came from
#' @param week filter the variable by certain week
#' @param group the groups to compare for the summary statistics
#' @param data the data to use 
#'
#' @return an summary statistic table of grouped variables
#' 
#' @family tableGen Functions
#' 
CDISC_mean <- function(column, week, group, data) {
  UseMethod("CDISC_mean", column)
}


#' @return NULL
#' @rdname CDISC_mean
#' @family tableGen Functions
CDISC_mean.default <- function(column, week, group, data) {
  rlang::abort(glue::glue(
    "Can't calculate mean because data is not classified as ADLB, BDS or OCCDS",
  ))
}

#' if ADSL supplied look for the column to take mean of
#' and look for a grouping variable to group_by
#'
#' @import dplyr
#' @importFrom rlang sym !! 
#' 
#' @return an summary statistic table of grouped variables
#' 
#' @param column the variable to perform summary statistics on,
#' this also contains the class of the column
#' based on the data file the column came from
#' @param week filter the variable by certain week
#' @param group the groups to compare for the summary statistics
#' @param data the data to use 
#' 
#' @family tableGen Functions
CDISC_mean.ADSL <- function(column, week, group = NULL, data) {
  
  column <- as.character(column)
  
  if (!is.numeric(data[[column]])) {
    stop(paste("Can't calculate mean, ", column, " is not numeric"))
  }
  
  if (!is.null(group)) {
    group <- sym(group)
    data %>%
      group_by(!!group) %>% 
      mean_summary(column) %>%
      transpose_df(1)
    
  } else {
    data %>%
      mean_summary(column) %>%
      transpose_df(999)
  }
  
}

#' if BDS filter by paramcd and week
#' We need to calculate the difference in N for this
#' and report missing values from the mean if any
#' @import dplyr
#' @importFrom rlang sym !!
#' 
#' @return an summary statistic table of grouped variables
#' 
#' @param column the variable to perform summary statistics on,
#' this also contains the class of the column
#' based on the data file the column came from
#' @param week filter the variable by certain week
#' @param group the groups to compare for the summary statistics
#' @param data the data to use 
#' 
#' @family tableGen Functions
CDISC_mean.BDS <- function(column, week, group = NULL, data) {
  
  column <- as.character(column)
  
  if (!column %in% data[["PARAMCD"]]) {
    stop(paste("Can't calculate mean, ", column, " has no AVAL"))
  }
  
  if (!is.null(group)) {
    
    if (week == "NONE") {
      stop("Please select a week from the MEAN dropdown to calculate mean of ", column)
    }
    
    group <- sym(group)
    data %>%
      filter(AVISIT == week & PARAMCD == column) %>%
      group_by(!!group) %>%
      mean_summary("AVAL") %>%
      transpose_df(1)
    
  } else {
    data %>%
      filter(AVISIT == week & PARAMCD == column) %>%
      mean_summary("AVAL") %>%
      transpose_df(999)
  }
}

#' @return NULL
#' @rdname CDISC_mean
#' 
#' @family tableGen Functions
CDISC_mean.OCCDS <- function(column, week = NULL, group, data) {
  rlang::abort(glue::glue(
    "Currently no method to perform summary statistics on OCCDS"
  ))
}

#' @return NULL
#' @rdname CDISC_mean
#' 
#' @family tableGen Functions
CDISC_mean.custom <- function(column, week = NULL, group, data) {
  rlang::abort(glue::glue(
    "Can't calculate mean, data is not classified as ADLB, BDS or OCCDS"
  ))
}