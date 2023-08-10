library(shiny)
library(reticulate)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shinycssloaders)
library(shinythemes)
library(tidyverse)
library(shinyBS)
library(shinyWidgets)
library(reactable)
library(data.table)
library(ggmsa)
library(msa)
###### Home
options(shiny.maxRequestSize=1024^4)
###### UI start
ui <- fluidPage(
  useShinyjs(),
  tags$script(type = "text/javascript",src="js/func.js"),
  tags$style(HTML("
          .navbar .navbar-nav {float: right}
          .navbar .navbar-header {margin-left: 5%}
          .navbar ul {margin-right: 5%}
          .container-fluid {padding-right: 0%;padding-left: 0%;}
          .navbar-default {background-color:#343A40}
          .col-sm-6 {width:30%;text-align:center;font-size: 100%;}
          #chloroplast ul li{width:230px;height:20px;}
          #chloroplast ul li a{width:230px;height:20px;padding-top: 0%}
          #chloroplast div {width:260px;}
          #circos {margin-left: -50%;}
          #circos img{width:680px;height:600px;}
          #info {border-radius: 10px;border:2px solid #C8C8C8;
                text-align: justify; text-justify: inter-ideograph;
                padding: 20px 20px}
         
          .col-sm-10 h3{text-align:center;font-size: 100%;}
          .zheng img {border-radius: 10px;border:2px solid #C8C8C8}
          .zheng {width:50%;float:right}
          .zheng p {text-align: justify; text-justify: inter-ideograph;}
          .mangrove .col-sm-6 {width:203px;text-align:center;font-size: 100%;}
          .box-body img {width:200px;height:160px}
          .box-title em{font-size: 15px}
          .box-body:hover{-moz-opacity:0.68 !important; filter:alpha(opacity=68); opacity:0.68; _-moz-opacity:0.68;}
        ")),
  navbarPage(
    title = strong('RNAeditDB',style = "font-size: 150%; color:#38A169"),
    id = 'navbar',
    windowTitle = "RNAeditDB",
    theme = shinytheme("flatly"),
    # home 
    tabPanel("Home",value ="Home",icon = icon('Home'),
             column(1,
             ),
             column(10,
                    
                    tags$h2("Welcome to RNAeditDB!",actionButton('cite',a(tags$span('Cite our paper',style="color:green;"),href="",target="view_window"))),
                    tags$hr(style="border-top: 3px dashed #A9A9A9"),
                    tags$p(strong("RNAeditDB is a database for identification of C-to-U RNA editing sites in the chloroplast of mangrove species.",
                                  style = "font-size: 100%;")),
             ),
             column(1,
                    
             ),
             #########
             column(12,
             ),
             column(1,
             ),
             column(10,
                    class="mangrove",
                    box(title =em('Aegiceras corniculatum'),
                        footer = '',
                        tags$a(img(src = "images/Acorniculatum.jpg"), onclick="customHref('information');customHref('Acorniculatum')")
                        ),
                    box(title =em('Avicennia officinalis'),
                        footer = '',
                        img(src = "images/Aofficinalis.jpg", onclick="customHref('information');customHref('Aofficinalis')")),
                    box(title =em('Avicennia rumphiana'),
                        footer = '',
                        img(src = "images/Arumphiana.jpg", onclick="customHref('information');customHref('Arumphiana')")),
                    box(title =em('Bruguiera gymnorhiza'),
                        footer = '',
                        img(src = "images/Bgymnorhiza.jpg", onclick="customHref('information');customHref('Bgymnorhiza')")),
                    box(title =em('Barringtonia racemosa'),
                        footer = '',
                        img(src = "images/Bracemosa.jpg", onclick="customHref('information');customHref('Bracemosa')")),
                    box(title =em('Ceriops tagal'),
                        footer = '',
                        img(src = "images/Ctagal.jpg", onclick="customHref('information');customHref('Ctagal')")),
                    box(title =em('Ceriops zippeliana'),
                        footer = '',
                        img(src = "images/Czippeliana.jpg", onclick="customHref('information');customHref('Czippeliana')")),
                    box(title =em('Heritiera littoralis'),
                        footer = '',
                        img(src = "images/Hlittoralis.jpg", onclick="customHref('information');customHref('Hlittoralis')")),
                    box(title =em('Kandelia obovata'),
                        footer = '',
                        img(src = "images/Kobovata.jpg", onclick="customHref('information');customHref('Kobovata')")),
                    box(title =em('Laguncularia racemosa'),
                        footer = '',
                        img(src = "images/Lagracemosa.jpg", onclick="customHref('information');customHref('Lagracemosa')")),
                    box(title =em('Lumnitzera littorea'),
                        footer = '',
                        img(src = "images/Llittorea.jpg", onclick="customHref('information');customHref('Llittorea')")),
                    box(title =em('Lumnitzera racemosa'),
                        footer = '',
                        img(src = "images/Lracemosa.jpg", onclick="customHref('information');customHref('Lracemosa')")),
                    box(title =em('Nypa fruticans'),
                        footer = '',
                        img(src = "images/Nfruticans.jpg", onclick="customHref('information');customHref('Nfruticans')")),
                    box(title =em('Pemphis acidula'),
                        footer = '',
                        img(src = "images/Pacidula.jpg", onclick="customHref('information');customHref('Pacidula')")),
                    box(title =em('Rhizophora apiculata'),
                        footer = '',
                        img(src = "images/Rapiculata.jpg", onclick="customHref('information');customHref('Rapiculata')")),
                    box(title =em('Rhizophora mucronata'),
                        footer = '',
                        img(src = "images/Rmucronata.jpg", onclick="customHref('information');customHref('Rmucronata')")),
                    box(title =em('Rhizophora stylosa'),
                        footer = '',
                        img(src = "images/Rstylosa.jpg", onclick="customHref('information');customHref('Rstylosa')")),
                    box(title =em('Sonneratia alba'),
                        footer = '',
                        img(src = "images/Salba.jpg", onclick="customHref('information');customHref('Salba')")),
                    box(title =em('Sonneratia apetala'),
                        footer = '',
                        img(src = "images/Sapetala.jpg", onclick="customHref('information');customHref('Sapetala')")),
                    box(title =em('Sonneratia caseolaris'),
                        footer = '',
                        img(src = "images/Scaseolaris.jpg", onclick="customHref('information');customHref('Scaseolaris')")),
                    box(title =em('Scyphiphora hydrophyllacea'),
                        footer = '',
                        img(src = "images/Shydrophyllacea.jpg", onclick="customHref('information');customHref('Shydrophyllacea')")),
                    box(title =em('Sonneratia ovata'),
                        footer = '',
                        img(src = "images/Sovata.jpg", onclick="customHref('information');customHref('Sovata')")),
                    box(title =em('Xylocarpus granatum'),
                        footer = '',
                        img(src = "images/Xgranatum.jpg", onclick="customHref('information');customHref('Xgranatum')")),
                    box(title =em('Xylocarpus moluccensis'),
                        footer = '',
                        img(src = "images/Xmoluccensis.jpg", onclick="customHref('information');customHref('Xmoluccensis')")),
             ),
             column(1,
                    
             ),
             ############
             column(12,
             ),
             ),
    tabPanel("Mangrove",value ="information",icon = icon('database'),
             column(4,
                    mainPanel(
                    id="chloroplast",
                    "Mangrove chloroplast genome",
                    navlistPanel(
                      id="genome",
                      tabPanel("Aegiceras corniculatum" ,value="Acorniculatum"),
                      tabPanel("Avicennia officinalis" ,value="Aofficinalis"),
                      tabPanel("Avicennia rumphiana" ,value="Arumphiana"),
                      tabPanel("Bruguiera gymnorhiza" ,value="Bgymnorhiza"),
                      tabPanel("Barringtonia racemosa" ,value="Bracemosa"),
                      tabPanel("Ceriops tagal" ,value="Ctagal"),
                      tabPanel("Ceriops zippeliana" ,value="Czippeliana"),
                      tabPanel("Heritiera littoralis" ,value="Hlittoralis"),
                      tabPanel("Kandelia obovata" ,value="Kobovata"),
                      tabPanel("Laguncularia racemosa" ,value="Lagracemosa"),
                      tabPanel("Lumnitzera littorea" ,value="Llittorea"),
                      tabPanel("Lumnitzera racemosa" ,value="Lracemosa"),
                      tabPanel("Nypa fruticans" ,value="Nfruticans"),
                      tabPanel("Pemphis acidula" ,value="Pacidula"),
                      tabPanel("Rhizophora apiculata" ,value="Rapiculata"),
                      tabPanel("Rhizophora mucronata" ,value="Rmucronata"),
                      tabPanel("Rhizophora stylosa" ,value="Rstylosa"),
                      tabPanel("Sonneratia alba" ,value="Salba"),
                      tabPanel("Sonneratia apetala" ,value="Sapetala"),
                      tabPanel("Sonneratia caseolaris" ,value="Scaseolaris"),
                      tabPanel("Scyphiphora hydrophyllacea" ,value="Shydrophyllacea"),
                      tabPanel("Sonneratia ovata" ,value="Sovata"),
                      tabPanel("Xylocarpus granatum" ,value="Xgranatum"),
                      tabPanel("Xylocarpus moluccensis" ,value="Xmoluccensis"),
                    ),
             ),
             ),
             column(4,
                    a(tags$span('The chloroplast genome visualization by Chloroplot R package',style="color:green;font-size:100%;float:right"),href="https://irscope.shinyapps.io/Chloroplot/",target="view_window"),
                    plotOutput("circos")
                    
             ),
             column(4,
                    textOutput("info")
             ),
             column(12,
             ),
    ),
    #################### home end
    tabPanel("RNAeditDB",value ="RNAeditDB",icon = icon('database'),
             column(1,
                    
             ),
             column(10,
                    tags$p(strong("Annotation and functional prediction of chloroplast C-to-U editing sites on the protein-coding genes in mangrove.",style = "font-size: 100%;")),
                    tags$hr(style="border-top: 3px dashed #A9A9A9"),
                    DT::dataTableOutput("CT") %>% withSpinner(color="#0dc5c1"),
                    style = "overflow-x: scroll;" ,
             ),
             column(1,
                    
             ),
    ),
    #####
    tabPanel("C2Umsa",value = 'C2Umsa',icon = icon("cloud"),
             column(2),
             column(8,
                    tags$p("This tool implements functions to visualize multiple sequence alignments.",
                           style = "font-size: 30px;"),
                    tags$hr(style="border-top: 3px dashed #A9A9A9"),
             ),
             column(12), 
             column(2),
             column(2,
                    selectInput(inputId = 'alignment',
                                label = 'Method:',
                                choices = c("Muscle","ClustalW", "ClustalOmega"),
                                width = "50%"),
             ),
             column(1,
                    textInput("Start", "Start:", 320),
             ),
             column(1,
                    textInput("End", "End:", 360),
             ),
             column(12),
             column(2),
             column(8,
                    fileInput("upload_fa", buttonLabel = "Upload...","Upload a file"),
             ),
             column(12),
             column(2),
             column(8,
                    plotOutput("msa") %>% withSpinner(color="#0dc5c1")
             ),
             column(2),
    ),
    ####
    tabPanel("PlantC2U",value = 'PlantC2U',icon = icon("cloud"),
             column(2,
             ),
             column(8,
                    tags$p("This tool scans for C-to-U RNA editing sites from your input sequences.",
                           style = "font-size: 30px;"),
                    tags$hr(style="border-top: 3px dashed #A9A9A9"),
             ),
             column(12,
             ),
             column(2,
             ),
             column(4,
                    selectInput(inputId = 'Model',
                                label = 'Flanking sequence length:',
                                choices = seq(20,100,10),
                                width = "50%"),
                    selectInput(inputId = 'Ratio',
                                label = 'Ratio',
                                choices = c("1:1","1:2","1:3","1:4","1:5"),
                                width = "50%"),
             ),
             column(12,
             ),
             column(2,
             ),
             column(8,
                    textAreaInput("sequence", "Input FASTA format sequence:", 
                                  width ="80%",
                                  value = ">example\nAATAGCAGGTTTAGCTTTATAGCTCGTCCCTTGAATATTG",
                                  rows = 5),
                    #actionButton("button", "Submit"),
             ),
             column(12,
                    
             ),
             column(2,
                    
             ),
             column(8,
                    tags$p(strong("Prediction of C-to-U RNA editing sites below:",style = "font-size: 100%;")),
                    tags$hr(style="border-top: 3px dashed #A9A9A9"),
                    DT::dataTableOutput("FASTA") %>% withSpinner(color="#0dc5c1"),
                    style = "overflow-x: scroll;" ,
             ),
             column(2,
                    
             ),
    ),
####

####
    tabPanel("About",value = 'About',icon = icon("envelope"),
             column(2,
             ),
             column(8,
                    
                    tags$h4(strong("PlantC2U: Deep learning of cross-species sequence landscapes predicts C-to-U RNA editing",
                                   style = "font-size: 100%;"),actionButton('cite',a(tags$span('Cite our paper',style="color:green;"),href="https://onlinelibrary.wiley.com/doi/10.1111/pbi.13893",target="view_window"))),
                    tags$hr(style="border-top: 2px solid #A9A9A9"),
                    tags$h4(tags$p("Corresponding Author")),
                    column(6,
                           class="zheng",
                           a(img(src = "images/zheng.jpg",title="E-mail: zhenghl@xmu.edu.cn",
                                 style='width:100%;height:250px;cursor:pointer;')
                             ,href="https://cee.xmu.edu.cn/info/1027/3458.htm",target="view_window"),
                           
                           
                    ),
                    column(6,
                           class="zheng",
                           tags$h4(strong("Hailei Zheng")),
                           tags$p("Distinguished Professor, College of the Environment and Ecology, Xiamen University"),
                           tags$p("Environmental botany, Plant physiological ecology and molecular biology, including plant adapatation to environmental stresses; Functions of nitric oxide and hydrogen sulfide on plants; Ecophysiology of mangrove wetland and biochemistry and molecular biology of mangrove plant tolerance to wetland habitats. Welcome to apply the Master degree, PhD degree and Post-doc position.")
                           
                    ),
                    column(12,
                    ),
                    
             ),
             column(2,
             ),
             #################
             
             
             ##########
    )
    

    

    
##########
  ),



)

shinyUI(ui)


###### UI end

