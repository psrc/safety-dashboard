shinyUI(
  
  navbarPage(
    
    id = "PSRC-Safety-Dashboard",
    tags$style("@import url(https://use.fontawesome.com/releases/v6.3.0/css/all.css);"),
    title = tags$a(div(tags$img(src='psrc-logo.png',
                             style="margin-top: -30px; padding-left: 40px;",
                             height = "80")
                             ), href="https://www.psrc.org", target="_blank"),
             tags$head(
               tags$style(HTML('.navbar-nav > li > a, .navbar-brand {
                            padding-top:25px !important; 
                            padding-bottom:0 !important;
                            height: 75px;
                            }
                           .navbar {min-height:25px !important;}'))
             ),
    
             windowTitle = "PSRC Geospatial Collision Analysis", 
             theme = "styles.css",
             position = "fixed-top",
             
             tabPanel(title=HTML("Overview"),
                      value="Main-Summary",
                      
                      banner_ui('overviewBanner'),
                      
                      fluidRow(column(4, style='padding-left:50px; padding-right:50px;',
                                      leftpanel_ui('overviewleftpanel')),
                               column(8, style='padding-left:0px; padding-right:50px;',
                                      br(),
                                      textOutput("safety_text_1"),
                                      br(),
                                      textOutput("safety_text_2"),
                                      br(),
                                      textOutput("safety_text_3"),
                                      br(), 
                                      textOutput("safety_text_4"),
                                      br(), 
                                      textOutput("safety_text_5"),
                                      br(), 
                                      div(img(src="04_PR-Winter2022_Feature_SSA-Overview2.jpg", width = "50%", height = "50%", style = "padding-top: 0px; border-radius:0px 0 0px 0;", alt = "Bar chart of Greenhouse Gas Emissions in 2050")),
                                      br(),
                                      hr()
                                      
                                      
                               )) # End of Main Panel Fluid Row for Main Overview Tab
             ), # End of Tab Panel for Main Overview
    
    tabPanel(title=HTML("Serious Injury Collisions"),
             value="Serious",
             banner_ui('seriousBanner'),
             
             fluidRow(column(4, style='padding-left:50px; padding-right:50px;',
                             leftpanel_ui('seriousleftpanel')),
                      
                      column(8,
                             tabsetPanel(type = "tabs",
                                         tabPanel("Geography", "Geograhpy Test"),
                                         tabPanel("Demographics", "Demographics Test"),
                                         tabPanel("Locations", "Location Test")
                                         )
                      ),
             ) # End of Main Panel Fluid Row for Serious Collisions Tab 
    ), # end Tabpanel for serious
             
    
    tabPanel(title="Fatal Collisions",
             value="Fatal",
             banner_ui('fatalBanner'),
             
             fluidRow(column(4, style='padding-left:50px; padding-right:50px;',
                             hr(),
                             strong(tags$div(class="sidebar_heading","Regional Transportation Plan")),
                             br(),
                             tags$a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/projects-and-approval", "Projects and Approval", target="_blank"),
                             hr(style = "border-top: 1px solid #000000;"),
                             tags$a(class = "source_url", href="https://www.psrc.org/coordinated-mobility-plan", "Coordinated Mobility Plan", target="_blank"),
                             hr(style = "border-top: 1px solid #000000;"),
                             tags$a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/data-research-and-policy-briefs", "Data, Research and Policy Briefs", target="_blank"),
                             hr(style = "border-top: 1px solid #000000;"),
                             tags$a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/transportation-system-visualization-tool", "Transportation System Visualization Tool", target="_blank"),
                             hr(style = "border-top: 1px solid #000000;"),
                             div(img(src="canyon_road.png", width = "100%", height = "100%", style = "padding-top: 0px; border-radius:30px 0 30px 0;", alt = "Glass and steel building in the background")),
                             hr(),
                             strong(tags$div(class="sidebar_heading","Connect With Us")),
                             hr(),
                             tags$div(class="sidebar_notes","Gary Simonson:"),
                             tags$div(class="sidebar_notes","Senior Planner"),
                             br(),
                             icon("envelope"), 
                             tags$a(class = "source_url", href="mailto:gsimonson@psrc.org?", "Email"),
                             br(), br(),
                             icon("phone-volume"), "206-971-3276",
                             hr()                                 
                             ), # end of left column for main panel fatal collisions
                      
                      column(8, style='padding-left:0px; padding-right:50px;',
                             
                             tabsetPanel(type = "tabs",
                                         
                                         tabPanel("Overview",
                                                  
                                                  br(),
                                                  textOutput("fatal_overview_text"),
                                                  br(),
                                                  hr(),

                                         ), # end of tabpanel set for Fatal Overview
                                         
                                         tabPanel("By Place",
                                                  
                                                  h1("Fatal Collisions in the PSRC Region"),
                                                  hr(),
                                                  strong(tags$div(class="chart_title","Annual Fatal Collisions in the PSRC Region")),
                                                  fluidRow(column(12,plotlyOutput("region_total_fatal_collisions_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collisions by Incorporation"),
                                                  fluidRow(column(6,strong(tags$div(class="chart_title","Total Fatalities"))),
                                                           column(6,strong(tags$div(class="chart_title","Fatality Rate per 100,000 people")))),
                                                  fluidRow(column(6,plotlyOutput("region_fatalities_incorporation_chart")),
                                                           column(6,plotlyOutput("region_rate_incorporation_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collisions by Regional Geography"),
                                                  fluidRow(column(6,strong(tags$div(class="chart_title","Total Fatalities"))),
                                                           column(6,strong(tags$div(class="chart_title","Total Population")))),
                                                  fluidRow(column(6,plotOutput("fatality_regional_geography_chart")),
                                                           column(6,plotOutput("population_regional_geography_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collisions by County in the PSRC Region"),
                                                  br(),
                                                  fluidRow(column(12, radioButtons("fatal_county_toggle", label = "Rate or Total",
                                                                                   choices = list("Total Fatalities" = "fatalities", "Fatality Rate per 100,000 people" = "fatality_rate"),
                                                                                   selected = "fatalities",
                                                                                   inline = TRUE))),
                                                  br(),
                                                  strong(tags$div(class="chart_title","Annual Fatal Collisions by County in the PSRC Region")),
                                                  fluidRow(column(12,plotlyOutput("county_total_fatal_collisions_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collision Rate by City"),
                                                  fluidRow(column(6,strong(tags$div(class="chart_title",paste0("5yr Fatality Rate per 100,000 people: ", previous_yr)))),
                                                           column(6,strong(tags$div(class="chart_title",paste0("5yr Fatality Rate per 100,000 people: ", latest_yr))))),
                                                  fluidRow(column(6,plotlyOutput("city_previous_rate_chart", height = "800px")),
                                                           column(6,plotlyOutput("city_latest_rate_chart", height = "800px"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                         ), # end of tabpanel set for Fatal Geography
                                         
                                         tabPanel("By Demographics", 
                                                  
                                                  h1("Fatal Collisions by Race & Ethnicity in the PSRC Region"),
                                                  br(),
                                                  fluidRow(column(6, radioButtons("fatal_race_toggle", label = "Rate or Total",
                                                                                  choices = list("Total Fatalities" = "fatalities", "Fatality Rate per 100,000 people" = "fatality_rate"),
                                                                                  selected = "fatalities")),
                                                           column(6, sliderInput("fatal_race_year", label = "Select Year", sep="", animate=TRUE, min = first_yr, max = latest_yr, value = 2021))),
                                                  br(),
                                                  strong(tags$div(class="chart_title",textOutput("region_fatalities_race_title"))),
                                                  fluidRow(column(12,plotlyOutput("region_fatalities_race_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collisions by Gender in the PSRC Region"),
                                                  br(),
                                                  fluidRow(column(12, radioButtons("fatal_gender_toggle", label = "Rate or Total",
                                                                                  choices = list("Total Fatalities" = "fatalities", "Fatality Rate per 100,000 people" = "fatality_rate"),
                                                                                  selected = "fatalities",
                                                                                  inline = TRUE))),
                                                  br(),
                                                  strong(tags$div(class="chart_title","Annual Fatal Collisions by Gender in the PSRC Region")),
                                                  fluidRow(column(12,plotlyOutput("region_fatalities_gender_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  h1("Fatal Collisions by Age in the PSRC Region"),
                                                  br(),
                                                  fluidRow(column(12, radioButtons("fatal_age_toggle", label = "Rate or Total",
                                                                                   choices = list("Total Fatalities" = "fatalities", "Fatality Rate per 100,000 people" = "fatality_rate"),
                                                                                   selected = "fatalities",
                                                                                   inline = TRUE))),
                                                  br(),
                                                  strong(tags$div(class="chart_title","Annual Fatal Collisions by Age in the PSRC Region")),
                                                  fluidRow(column(12,plotlyOutput("region_fatalities_age_chart"))),
                                                  tags$div(class="chart_source","Source: Washington State Coded Fatal Crash (CFC) analytical data files, Washington Traffic Safety Commision"),
                                                  hr(),
                                                  
                                                  
                                         ), # end of tabpanel set for Fatal Demographics
                                         
                                         tabPanel("Locations", "Location Test")
                             ) # end of tabset panel for Fatal Collisions
                             
                      ) # End of Main Panel Fluid Row for Regional Fatal Collisions Tab
             ) # End of Main Panel Fluid Row for Regional Fatal Collisions Tab
          ), # End of Tab Panel for Fatal Summary
                        
    
    tags$footer(footer_ui('psrcfooter'))
    
             ) # End of NavBar Page
  ) # End of Shiny App
