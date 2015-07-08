install.packages("data.table", lib="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

sv <- read.csv("~/Desktop/cumtotal/sv.csv")
require(data.table)
View(sv)
setDT (sv)

setkey(sv, Company,Month)
sv[,csum := cumsum(New.Employees),by=Company]
View(sv)
