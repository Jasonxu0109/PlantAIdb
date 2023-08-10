library(reticulate)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shinycssloaders)
library(tidyverse)
library(DT)
library(readxl)
library(cowplot)
library(stringr)
library(reactable)
library(data.table)
library(keras)
library(tensorflow)
library(ggmsa)
library(msa)
source("data/transfer.r")
keras <- import("keras")
info <- sc_dataset <- read_excel('data/information.xlsx')
CT <- read_excel('data/24mangrove.xlsx')
server <- function(input, output, session) {
  output$circos <-renderImage({
    filename <- paste0("www/images/", input$genome, ".png")
    list(src = filename,
         contentType = 'image/png',
         width = 400,
         height = 400)
  },deleteFile=FALSE)
  output$info <- renderText({
    info2 <- info %>%
      filter(Org2==input$genome)
    info2$Info
  })
  output$CT <- renderDataTable(
    DT::datatable({
      CT
    },
    selection = list(mode='single', selected=NULL)),
  )
  output$FASTA <- renderDataTable({
    Seq <- input$sequence
    Seq <- unlist(str_split(Seq,">"))
    Seq <- Seq[-1]
    test_seq <- c()
    ID <- c()
    for(i in 1:length(Seq)){
      seq2 <- unlist(str_split(Seq[i],"[ \n]"))
      id <- seq2[1]
      nucl <- seq2[2]
      test_seq <- c(test_seq,toupper(nucl))
      ID <- c(ID,id)
    }
    if(input$Ratio=="1:1"){
      Ratio <- 1
    }else if(input$Ratio=="1:2"){
      Ratio <- 2
    }else if(input$Ratio=="1:3"){
      Ratio <- 3
    }else if(input$Ratio=="1:4"){
      Ratio <- 4
    }else if(input$Ratio=="1:5"){
      Ratio <- 5
    }
    CTModel <- paste0("data/","Choose_flank_",input$Model,"_ratio_",Ratio,".hdf5")
    model <- keras$models$load_model(CTModel)
    encoded_seq <- EncodingSeq(test_seq)
    flank_len <- as.numeric(input$Model)
    x_test <- convStringToMatrix(encoded_seq,seq_len=flank_len*2)
    classes <- model$predict(x_test)
    Probability <- classes[,2]
    new_tab <- data.frame(ID=ID,RNA_input_seq=test_seq,Probability)
    new_tab
  })
  
  ### MSA
  
  MSA <- reactive({
    upload_fa <- input$upload_fa
    if (!is.null(upload_fa)){
      aln <- readAAStringSet(upload_fa$datapath)
    }else{
      aln <- readAAStringSet("data/ndhA.pep")
    }
  })

  output$msa <- renderPlot({
    aln <- MSA()
    aln2 <- msa(aln,method=input$alignment)
    total <- width(aln2@unmasked)[1]
    start <- as.numeric(input$Start)
    end <- as.numeric(input$End)
    end <- ifelse(end>total,total,end)
    ggmsa(aln2@unmasked, start, end, color = "Chemistry_AA", 
          font = "TimesNewRoman", char_width = 0.5, seq_name = TRUE )+
      #geom_seqlogo(color = "Chemistry_AA")+
      theme(axis.text = element_text(size=12,color='black'))+
      facet_msa(field = 80)
    
  },height = 250)
  
  

}


