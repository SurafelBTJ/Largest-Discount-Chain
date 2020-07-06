library(shiny)

Largest_discount_store_chains_1968 <- read_excel("Downloads/Largest discount store chains 1968.xls", 
                                                 +     col_types = c("numeric", "text", "text", 
                                                                     +         "numeric", "numeric", "numeric", 
                                                                     +         "text", "numeric"))
ui <- fluidPage(
  headerPanel("Columns"),
  sidebarPanel(
  selectInput('hist','Variable',names(Largest_discount_store_chains_1968)),
  selectInput('box','Variable',names(Largest_discount_store_chains_1968)),
  selectInput('ylab','Y Variable',names(Largest_discount_store_chains_1968)),
  selectInput('xlab','X Variable',names(Largest_discount_store_chains_1968)),
  
  
            selected = names(Largest_discount_store_chains_1968)[[2]]),
  mainPanel(
  plotOutput('hist'),
  plotOutput('box'),
  plotOutput('scatter')
  
  )
)

server <- function(input, output, session) {
  selecthist<-reactive({input$hist
    })
  selectbox<-reactive({input$box
  })
  selectxlab<-reactive({input$xlab
    })
  selectsylab<-reactive({input$ylab
  })
  output$hist<-renderPlot({
    req(selecthist())
    hist(Largest_discount_store_chains_1968[[selecthist()]],xlab = "Revenue",main = "Histogram of revenue")
    })
  output$box<-renderPlot({
    req(selectbox())
    boxplot(Largest_discount_store_chains_1968[[selectbox()]],xlab="Revenue",main="BoxPlot of revenue")
  })
  output$scatter<-renderPlot({
    req(selectxlab())
    req(selectsylab())
    plot(Largest_discount_store_chains_1968[[selectxlab()]],Largest_discount_store_chains_1968[[selectsylab()]])
  })
  
}

shinyApp(ui, server)
