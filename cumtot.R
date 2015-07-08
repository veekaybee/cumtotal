sv <- read.csv("~/Desktop/ipythondata/sv.csv")
require(data.table)
View(sv)
setDT (sv)

setkey(sv, Company,Month)
sv[,csum := cumsum(New.Employees),by=Company]
View(sv)
