##################################################
##r shiny dashboard for WDDS work
# devleoper by fatemeh.torabi@swansea.ac.uk
# first published online version date: 2021-01-25
#sail IGRP: 0911v: COVID-19
##################################################
library("shinydashboard")
library("ggplot2")
library("ggthemes")
#library("dplyr")
#loading my data
BNF <- read.csv("WDDS.csv")
BNFESR <- read.csv("WDDSESR.csv")
Sys.setlocale('LC_ALL','C')

#BNFESR  <-BNFESR%>%
#  mutate(AGE_SPECIFIC_RATE= (TOTAL_DISPENSED_ITEMS/POPULATION)*100000)%>%
#  mutate(ESR=AGE_SPECIFIC_RATE*ESP)


BNFESR$AGE_SPECIFIC_RATE <-(BNFESR$TOTAL_DISPENSED_ITEMS/BNFESR$POPULATION)*100000
BNFESR$ESR<-BNFESR$AGE_SPECIFIC_RATE*BNFESR$ESP
month_names <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
age_bands <-c("<1","1-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59",
              "60-64","65-69","70-74","75-79","80-84","85-89","90-94","95+")

##header
header<-dashboardHeader(title = " ",
                            tags$li(a(href = 'https://popdatasci.swan.ac.uk/news/one-wales/',
                                      img(src = 'fig/HDRUK.png',
                                          title = "Company Home", height = "90 px", width ="1000 px"),
                                      style = "padding-top:10px; padding-bottom:10px;"),
                                    class = "dropdown"))



##defining sidebar layout
sidebar<-dashboardSidebar(
  sidebarMenu(
    menuItem("Overview",
             tabName = "Overview"
    ),
    menuItem("Annual Graphs",
             tabName = "graph"),
    menuItem("ESR Graphs",
             tabName = "graphesr"),
    menuItem("Annual Data",
             tabName = "data"
    ),
    menuItem("ESR Data",
             tabName = "dataesr"
    )
  )
)

##body of my dashboard
body<-dashboardBody(
  tabItems(
##first TAB: Title and abstract:  
  tabItem(
    tabName = "Overview",
    h1("Impact of COVID-19 pandemic on community medication dispensing: a national cohort analysis in Wales, UK."),
    em("Fatemeh Torabi*, Ashley Akbari*, Laura North, Daniel Harris, Gareth Davies, Mike Gravenor, Stuart Bedston, Hoda Abbasizanjani, Rowena Griffiths, Jane Lyons, Neil Jenkins, Andrew Morris, Julian Halcox, Ronan A. Lyons"),
    h3(strong("Abstract")),
    h3("Background"),
    h4("Population level information on dispensed medication provides insight on the distribution of treated morbidities, particularly if linked to other population-scale data at an individual-level."),
    h4(""),
    h4("Objective - To evaluate efficiently the impact of COVID-19 on dispensing patterns of medications."),
    h3(""),
    h3("Methods"),
    h4("Retrospective observational study using population-scale, individual-level dispensing records in Wales, UK. Total dispensed drug items for the population between 1st January 2016 and 31st December 2019 (3-years, pre-COVID-19) were compared to 2020 (1-year, COVID-19 period) up to 27th July 2021. We compared trends across all years and BNF chapters and highlighted the trends in three major British National Formulary (BNF) chapters for 2019-21: 1-Cardiovascular system (CVD), 2-Central Nervous System (CNS), 3-Immunological & Vaccine. We developed an interactive dashboard to enable monitoring of changes as the pandemic evolves."),
    h3(""),
    h3("Results"),
    h4("Amongst all BNF chapters, 73,410,543 items were dispensed in 2020 compared to 74,121,180 items in 2019 demonstrating -0.96% relative decrease in 2020. Comparison of monthly patterns showed average difference (D) of -59,220 and average Relative Change (RC) of -0.74% between number of dispensed items in 2020 and 2019. Maximum RC was observed in March 2020 (D= +1,224,909 and RC= +20.62%), followed by second peak in June 2020 (D= +257,920 RC= +4.50%). A third peak was observed in September 2020 (D= +264,138, RC= +4.35%). Large increases in March 2020 were observed for CVD and CNS medications, across all age groups. The Immunological and Vaccine products, dropped to very low levels across all age groups, and all months (including the March dispensing peak)."),
    h3(""),
    h3("Conclusions"),
    h4("Aberration in routine clinical service during COVID-19 led to substantial changes in community pharmacy drug dispensing. This change may contribute to a long-term burden of COVID-19, raising the importance of a comprehensive and timely monitoring of changes for evaluation of the potential impact on clinical care and outcomes."),
    h1("       "),
    h1("       "),
    h1("       "),
  h4("Note for researchers: Please ensure to use appropriate citation if you are using materials or data available from this website"),  
  h1("       "),
  h1("       "),
    h5(strong("This web application is developed by Fatemeh Torabi. Source code is available on GitHub. For queries about this web application or suggestions for additional functionalities, please contact via twitter @fatemetrb | via email: fatemeh.torabi@swansea.ac.uk"))
        ),
##################################################
#graph--------------------------------------------
tabItem(tabName = "graph",
        sliderInput(input="MNTH", label = "Month of Dispensing", ticks=TRUE, min=1,max=12,value=9),
#-----
       checkboxGroupInput("YR","Year of dispensing", 
                           choices = c("2021","2020","2019","2018","2017","2016"), selected = c("2021","2020","2019","2018","2017","2016")
        ),
#-----
        selectInput("BNF","BNF Chapter", 
                    choices = c( "Anaesthesia","Appliances","Cardiovascular System","Central Nervous System","Dressings",
                                 "Ear, Nose and Oropharynx","Endocrine System","Eye","Gastro-Intestinal System",
                                 "Immunological Products & Vaccines","Incontinence Appliances","Infections",
                                 "Malignant Disease & Immunosuppression","Musculoskeletal & Joint Diseases",
                                 "Nutrition and Blood","Obstetrics,Gynae+Urinary Tract Disorders",
                                 "Other Drugs and Preparations","Respiratory System","Skin","Stoma Appliances"),

                    #c(unique(BNF$BNF_CHAPTER)),
                    selected = "Cardiovascular System", multiple = FALSE),
#put the graph where I want
fluidRow(
      h3("  Total number of dispensed items per BNF chapter per month"),
      box(plotOutput(outputId = "graph")), height=1)
        ),
#graphesr---------------------------------------
tabItem(tabName = "graphesr",
        sliderInput(input="mnth", label = "Month of Dispensing", min=1,max=12,value=1),
        #-----
        #-----
        checkboxGroupInput("YRE","Year of dispensing", 
                           choices = c("2021","2020","2019","2018","2017","2016"), selected = c("2021","2020","2019","2018","2017","2016")
        ),
        #-----
        radioButtons("BNFESR","BNF Chapter", 
                    choices = c("Immunological Products & Vaccines","Central Nervous System","Cardiovascular System" ),
                    selected = "Cardiovascular System"),
#put the graph where I want
fluidRow(
      h3("  Age-standardized dispensing rates in last selected month of dispensing and selected BNF chapter"),
      box(plotOutput(outputId = "graphesr")),width= "90%"),
      h4(" Monthly breakdown: Age-standardized dispensing rates in the selected BNF chapter and all months up to the selected month of Dispensing (use slider on top of the page to select month of dispensing)"),
      h5("[1: January | 2: February | 3: March | 4: April | 5: May | 6: June | 7: July | 8: August | 9: September | 10: October | 11: November | 12: December]"),
      plotOutput(outputId = "graphesrfacet",width= "90%", height = "1000")
),
#------------------------------------------------
#changed to 4th tab: Yearly and monthly Data
tabItem(
  tabName = "data",
  infoBox(
    width = NULL,
    title = "Welsh Dispensing DataSet",
    subtitle = "Total number of dispensed item per Year, Month and BNF Chapter",
    icon = icon("database")
  ),
  h4("Total number of dispensed item per month of year per BNF chapter between 1st of January 2016 and 30th of September 2020. (any counts <10 were removed)"),
  downloadButton("downloadBNF",label = "Download the data"),
  tableOutput("BNF")
),
#changed to 5th tab: ESR data for 3 BNF
tabItem(
  tabName = "dataesr",
  infoBox(
    width = NULL,
    title = "Welsh Dispensing DataSet",
    subtitle = "European Standardized Rates (ESR) dispensing rates per Month, age band and BNF Chapter",
    icon = icon("database")
  ),
  h4("Age-standardised dispensing rates per 100,000 population for all ages up to 95+ using the 2013 European Standard Population (ESP)"),
  downloadButton("downloadBNFESR",label = "Download the data"),
  tableOutput("BNFESR")
  #  ,downloadButton("BNFESR",label = "Download the data")
)

)
)


ui<-dashboardPage(header, sidebar, body)


##server---------------------------------------------
server <-function(input, output, session){
#reading data tables in 
    output$BNF <- renderTable({BNF})
    output$BNFESR <- renderTable({BNFESR})
##downloadable csv of data@
    output$downloadBNF <-downloadHandler(
      filename = function(){
        paste("BNF", ".csv", sep="")
      },
      content = function(file){
        write.csv(BNF,file,row.names = FALSE)
      }
    )
##downloadable csv of data: BNFESR
    output$downloadBNFESR <-downloadHandler(
      filename = function(){
        paste("BNFESR", ".csv", sep="")
      },
      content = function(file){
        write.csv(BNFESR,file,row.names = FALSE)
      }
    )    
##graph
  output$graph <- renderPlot({
      #subset the data by chosen year
#      BNF<-BNF%>% 
#       filter(BNF_CHAPTER==c(input$BNF))%>%
#        filter(YR==c(input$YR))%>%
#        arrange(MNTH)
      
      BNF<-subset(BNF, BNF_CHAPTER==c(input$BNF))
      BNF<-subset(BNF, MNTH<= input$MNTH)
      BNF<-subset(BNF, YR==input$YR[1] | YR==input$YR[2]| YR==input$YR[3]|YR==input$YR[4]|YR==input$YR[5]|YR==input$YR[6])
      
      ggplot(BNF, aes(x=as.factor(MNTH), y=TOTAL_ITEMS, group=YR, colour=factor(YR)))+
        geom_line(size=1)+
        labs(color="Year", size=20)+
        guides(alpha= FALSE)+
        #    facet_wrap(.~input$BNF, scales = "free")+
        xlab("Month of dispensed")+
        ylab("Total dispensed items")+
        scale_x_discrete(labels=month_names)+
        theme_gdocs()+
        scale_color_manual(values=c("2016"="#B1CAD2", "2017"="#FFDB99","2018"="#45B0AD","2019"="#AFDD7E","2020"="#296EB4","2021"="red"))+
        geom_vline(xintercept = as.numeric(3.7),linetype="dotted", color="purple", size=1.0)+
        annotate("text", x = as.numeric(3.5),y=as.numeric(100),label=".                                          National Lockdown (23/03/20)", colour= "purple", size= 6, angle=90)+
        ggtitle("   ")+
        scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
    })
##graphesr 
  output$graphesr<-renderPlot({
#    BNFESR<-BNFESR%>% 
#      filter(BNF_CHAPTER==input$BNFESR)%>%
#      filter(MNTH==input$mnth)
    BNFESR<-subset(BNFESR,BNF_CHAPTER==input$BNFESR)
    BNFESR<-subset(BNFESR,MNTH == input$mnth)
    BNFESR<-subset(BNFESR, YR==input$YRE[1] | YR==input$YRE[2]| YR==input$YRE[3]|YR==input$YRE[4]|YR==input$YRE[5]|YR==input$YRE[6])
    
       
    ggplot(BNFESR, aes(x=STD_AGE_BAND, y= as.integer(ESR), group = YR, colour=factor(YR)))+
      geom_line(size=1)+
      labs(color="Year", size=20)+
      guides(alpha = FALSE) +
      xlab("Age group")+
      ylab("standardised dispensing rates per 100,000 population")+
      scale_x_discrete(labels= age_bands)+
      theme_calc()+
      scale_color_manual(values = c("2016"="#B1CAD2","2017"="#FFDB99","2018"="#45B0AD" ,"2019" ="#AFDD7E", "2020"="#296EB4","2021"="red"))+
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, color="#B09398", size=16))+
      theme(legend.position = "top", legend.direction = "horizontal",legend.background = element_rect(fill = "white"), legend.title = element_blank(), legend.text = element_text(size=14))+
      labs(fill="Categories")+
      theme(axis.text.y = element_text(size=16),
      axis.title.y = element_text(size=12))+
      title("Age-standardised dispensing rates per 100,000 population using 2013 Eropean Standard Population (ESP)")+
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
    
      })
##faceted esr graph
  output$graphesrfacet<-renderPlot({
    #    BNFESR<-BNFESR%>% 
    #      filter(BNF_CHAPTER==input$BNFESR)%>%
    #      filter(MNTH==input$mnth)
    BNFESR<-subset(BNFESR,BNF_CHAPTER==input$BNFESR)
    BNFESR<-subset(BNFESR,MNTH <= input$mnth)
    BNFESR<-subset(BNFESR, YR==input$YRE[1] | YR==input$YRE[2]| YR==input$YRE[3]|YR==input$YRE[4]|YR==input$YRE[5]|YR==input$YRE[6])
    
    month_names <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

      ggplot(BNFESR, aes(x=STD_AGE_BAND, y= as.integer(ESR), group = YR, colour=factor(YR)))+
      geom_line(size=1)+
      labs(color="Year", size=20)+
      guides(alpha = FALSE) +
      scale_x_discrete(labels=month_names)+
      facet_wrap(.~MNTH)+
      xlab("Age group")+
      ylab("standardised dispensing rates per 100,000 population)")+
      scale_x_discrete(labels= age_bands)+
      theme_calc()+
      scale_color_manual(values = c("2016"="#B1CAD2","2017"="#FFDB99","2018"="#45B0AD" ,"2019" ="#AFDD7E", "2020"="#296EB4","2021"="red"))+
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, color="#B09398", size=10))+
      theme(legend.position = "top", legend.direction = "horizontal",legend.background = element_rect(fill = "white"), legend.title = element_blank(), legend.text = element_text(size=14))+
      labs(fill="Categories")+
      theme(axis.text.y = element_text(size=16),
            axis.title.y = element_text(size=12))+
      title("Age-standardised dispensing rates per 100,000 population using 2013 Eropean Standard Population (ESP)")+
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
    
  })
  
  }
    
  shiny::shinyApp(ui,server)
  