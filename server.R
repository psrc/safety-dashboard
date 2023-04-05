# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  footer_server('psrcfooter')
  
  leftpanel_server('seriousleftpanel',
                   contact_name = "Gary Simonson",
                   contact_phone = "206-971-3276",
                   contact_email = "gsimonson@psrc.org",
                   contact_title = "Senior Planner",
                   photo_filename = "canyon_road.png")
  
  leftpanel_server('overviewleftpanel',
                   contact_name = "Craig Helmann",
                   contact_phone = "206-389-2889",
                   contact_email = "chelmann@psrc.org",
                   contact_title = "Director of Data",
                   photo_filename = "climate-image.png")
  
  banner_server('overviewBanner', 
                photo_filename = "street-intersection.jpeg", 
                banner_title = "Addressing Safety: Target Zero", 
                banner_subtitle = "Regional Transportation Plan",
                banner_url = "https://www.psrc.org/planning-2050/regional-transportation-plan")
  
  banner_server('fatalBanner', 
                banner_title = "Fatal Collisions", 
                banner_subtitle = "Regional Transportation Plan",
                banner_url = "https://www.psrc.org/planning-2050/regional-transportation-plan")
  
  banner_server('seriousBanner', 
                banner_title = "Serious Injury Collisions", 
                banner_subtitle = "Regional Transportation Plan",
                banner_url = "https://www.psrc.org/planning-2050/regional-transportation-plan")
  
  output$fatal_overview_text <- renderText({fatal_overiew_1})
  
  output$safety_text_1 <- renderText({safety_overview_1})
  
  output$safety_text_2 <- renderText({safety_overview_2})
  
  output$safety_text_3 <- renderText({safety_overview_3})
  
  output$safety_text_4 <- renderText({safety_overview_4})
  
  output$safety_text_5 <- renderText({safety_overview_5})

# Fatal Collisions by Geography -------------------------------------------
  output$region_total_fatal_collisions_chart <- renderPlotly({psrcplot:::make_interactive(static_line_chart(t=data %>% filter(variable=="Region" & grouping=="All" & metric=="1-year average for fatal collisions") %>%
                                                                                                              select("year", Fatalities="fatalities", `Fatal Collisions`="fatal_collisions") %>%
                                                                                                              pivot_longer(!year),
                                                                                                            x='year', y='value', fill='name', est="number",
                                                                                                            lwidth = 2, color = "pgnobgy_5") +
                                                                                            ggplot2::scale_y_continuous(limits=c(0,400), labels=scales::label_comma()))})
  
  output$county_total_fatal_collisions_chart <- renderPlotly({psrcplot:::make_interactive(static_line_chart(t=data %>% filter(variable=="County" & grouping=="All" & metric=="1-year average for fatal collisions"),
                                                                                                            x='year', y=input$fatal_county_toggle, fill='geography', est="number",
                                                                                                            lwidth = 2, color = "pgnobgy_5",
                                                                                                            dec=if(input$fatal_county_toggle=="fatality_rate") {dec=1} else {dec=0}) +
                                                                                            ggplot2::scale_y_continuous(limits=c(0,
                                                                                                                                 round(data %>% filter(variable=="County" & grouping=="All" & metric=="1-year average for fatal collisions") %>% select(all_of(input$fatal_county_toggle)) %>% pull() %>% max()*1.25,0)),
                                                                                                                        labels=scales::label_comma()))})
  
  output$region_fatalities_incorporation_chart <- renderPlotly({interactive_column_chart(t=data %>% filter(variable=="Region" & grouping!="All" & metric=="1-year average for fatal collisions") %>% select("data_year", Fatalities="fatalities", "grouping"),
                                                                                         x="data_year", y="Fatalities", fill="grouping", est="number", pos="stack", color="obgnpgy_5")})
  
  output$region_rate_incorporation_chart <- renderPlotly({interactive_column_chart(t=data %>% filter(variable=="Region" & grouping!="All" & metric=="1-year average for fatal collisions") %>% select("data_year", `Fatality Rate`="fatality_rate", "grouping"),
                                                                                   x="data_year", y="Fatality Rate", fill="grouping", est="number", dec=1, color="obgnpgy_5")})

  output$fatality_regional_geography_chart <- renderPlot({create_treemap_chart(t=data %>% filter(variable=="Regional Geography" & grouping=="All" & data_year=="2021" & metric=="1-year average for fatal collisions") %>% select("data_year", Fatalities="fatalities", "geography"),
                                                                                 s="Fatalities", fill="geography", est="number")})
  
  output$population_regional_geography_chart <- renderPlot({create_treemap_chart(t=data %>% filter(variable=="Regional Geography" & grouping=="All" & data_year=="2021" & metric=="1-year average for fatal collisions") %>% select("data_year", `Population`="population", "geography"),
                                                                                      s="Population", fill="geography", est="number", dec=0)})
  
  output$city_latest_rate_chart <- renderPlotly({interactive_bar_chart(t=city_latest %>%mutate(geography=forcats::fct_reorder(geography, -Fatalities)),
                                                                       x="Fatalities", y="geography", fill="grouping", est="number", color="purples_dec", dec=1)})
    
  output$city_previous_rate_chart <- renderPlotly({interactive_bar_chart(t=city_previous %>% mutate(geography=forcats::fct_reorder(geography, -Fatalities)),
                                                                       x="Fatalities", y="geography", fill="grouping", est="number", color="oranges_dec", dec=1)})
  
# Fatal Collisions by Demographics ----------------------------------------

  output$region_fatalities_race_title <- renderText({paste0("Annual Fatal Collisions by Race in the PSRC Region: ", input$fatal_race_year)})
  
  output$region_fatalities_race_chart <- renderPlotly({interactive_column_chart(t=data %>% filter(variable=="Race & Ethnicity" & geography=="Region" & metric=="1-year average for fatal collisions" & year==input$fatal_race_year) %>% mutate(grouping = str_wrap(grouping, width=15)),
                                                                                x="grouping", y=input$fatal_race_toggle, fill="grouping", est="number", color="pgnobgy_10", 
                                                                                dec=if(input$fatal_race_toggle=="fatality_rate") {dec=1} else {dec=0})})

  output$region_fatalities_gender_chart <- renderPlotly({interactive_column_chart(t=data %>% filter(variable=="Gender" & geography=="Region" & metric=="1-year average for fatal collisions"),
                                                                                x="data_year", y=input$fatal_gender_toggle, fill="grouping", est="number", color="pgnobgy_10", 
                                                                                dec=if(input$fatal_gender_toggle=="fatality_rate") {dec=1} else {dec=0},
                                                                                pos=if(input$fatal_gender_toggle=="fatality_rate") {pos="dodge"} else {pos="stack"})})
  

  output$region_fatalities_age_chart <- renderPlotly({interactive_column_chart(t=data %>% filter(variable=="Age" & geography=="Region" & metric=="1-year average for fatal collisions"),
                                                                                  x="data_year", y=input$fatal_age_toggle, fill="grouping", est="number", color="obgnpgy_10", 
                                                                                  dec=if(input$fatal_age_toggle=="fatality_rate") {dec=1} else {dec=0},
                                                                                  pos=if(input$fatal_age_toggle=="fatality_rate") {pos="dodge"} else {pos="stack"})})
  
   
})    

