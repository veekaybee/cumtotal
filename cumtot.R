sv <- read.csv("~/Desktop/ipythondata/sv.csv")
View(sv)
require(data.table)
import data.table
library data.table-package
library(data.table)
install.packages("data.table")
install.packages("data.table")
require(data.table)
setDT(dat)
setDT(dat)
setDT(sv)
setkey(sv, company,month)
setkey(sv, Company,Month)
sv[,csum:=cumsum(New.Employes),by=Company]
sv[,csum:=cumsum(New.Employees),by=Company]
library(plyr)
rename (sv, c("New.Employees"="nemp"))
rename (sv, c("New.Employess"="nemp"))
sv[,csum:=cumsum(nemp),by=Company]
