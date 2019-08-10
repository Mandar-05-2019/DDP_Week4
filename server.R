 library(shiny)
 library('ggplot2')
 

 
 # Define server logic required to draw a histogram
 shinyServer(function(input, output) {
         
         output$myplot <- renderPlot({
                 
                 plot(x = diamonds$carat, y = diamonds$price, cex = 0.5, pch = 20, col = "grey",
                      xlab = "carat", ylab = "price", main = "Diamond price prediction\n with respect to carat(s)")
                 
                 sample_data <- data.frame(carat = input$carat)
                 new_data <- data.frame(carat = diamonds$carat)
                 
                 if(input$lin_mod == TRUE){
                         
                         fit <- lm(price ~ carat, data = diamonds)
                         
                         new_out <- predict(fit, new_data)
                         out_price <- predict(fit, sample_data)
                        
                         abline(fit, lwd = 2, col = "red")
                         
                         lines(x=c(0,input$carat),y=c(out_price,out_price), lty = 4, col = "red")
                         lines(x=c(input$carat,input$carat),y=c(0,out_price), lty = 4, col = "red")
                         
                         points(x=c(input$carat),y=c(out_price), cex = 2.0, pch = 16, col = "red")
                         text(x=0.5, y=out_price, pos = 3, labels = c(as.character(round(out_price,2))),
                              font=4, col = "red")
                 }
                 
                 if(input$non_lin_mod == TRUE){
                         diamonds$carat_log <- sqrt(diamonds$carat)
                         sample_data$carat_log <- sqrt(sample_data$carat)
                         new_data$carat_log <- sqrt(new_data$carat)
                         
                         fit_2 <- lm(price ~ carat_log , data = diamonds)
                         
                         sorted_new_data <- new_data[order(new_data$carat_log),]
                         
                         new_out <- predict(fit_2, sorted_new_data)
                         out_price <- predict(fit_2, sample_data)
                         
                         lines(x=sorted_new_data$carat, y=new_out,lwd = 2, col = "blue")
                         
                         lines(x=c(0,input$carat),y=c(out_price,out_price), lty = 4, col = "blue")
                         lines(x=c(input$carat,input$carat),y=c(0,out_price), lty = 4, col = "blue")
                         points(x=c(input$carat),y=c(out_price), cex = 2.0, pch = 16, col = "blue")
                         
                         text(x=0.5, y=out_price, pos = 1, labels = c(as.character(round(out_price,2))),
                              font=4, col = "blue")
                 }
     })

 })
