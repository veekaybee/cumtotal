# Working through a blog post to do cumulative totals a couple different ways
Cumulative totals a couple different ways: R, Python, SQL, etc. 

#Blog Post in progress

#Cumulative totals three different ways in data science

![image](http://nancyfriedman.typepad.com/.a/6a00d8341c4f9453ef01a73dafb230970d-pi =400x300) 

Many people who analyze data have moved away from pre-built querying tools like Crystal Reports (**shudder**), OLAP cubes, and Excel, to IPython environments and R scripts.

But SQL is still extremely important to pulling together datasets for analysis. 

Oftentimes, I'll find myself requiring a dataset that involves having a running total by category for linear regression or just simple plotting. But that data is only available at a granular level. 

For example, let's say we want to find out how many total employees each of these Silicon Valley Companies have in any given month 

| Company       | Employees        | Month|
| ------------- |:-------------:| -----:|
| Hooli     | 123,456 | Jan-2014 |
| Hooli     | 1,434     |   Feb-2014|
| Hooli | 2,455     |    Mar-2014 |
| Pied Piper     | 1 | Jan-2014|
| Pied Piper     | 2     |   Feb-2014 |
| Pied Piper | 2     |   Mar-2014 |
| Raviga     | 50 |Jan-2014 |
| Raviga      | -2      |   Feb-2014|
| Raviga | 17      |    Mar-2014 |

and we only have how many they started with and net adds:   


| Company       | Employees        | Month|
| ------------- |:-------------:| -----:|
| Hooli     | 123,456 | Jan-2014 |
| Hooli     | 124,890     |   Feb-2014|
| Hooli | 127,345     |    Mar-2014 |
| Pied Piper     | 1 | Jan-2014|
| Pied Piper     | 3     |   Feb-2014 |
| Pied Piper | 5     |   Mar-2014 |
| Raviga     | 50 |Jan-2014 |
| Raviga      | 48      |   Feb-2014|
| Raviga | 65      |    Mar-2014 |

What I often want to do is create a cumulative total, by month and by company. In Excel, this is super-easy, if annoying: 

(![image](http://))

This becomes much more annoying when I have any more than 100 rows of data, because then I'm resorting to cut and paste and manually tweaking. As soon as I start to do things manually, I make mistakes, and it's [not very good data practice](https://github.com/jtleek/datasharing) to have code you can't reproduce. 

So here are three typical ways to do cumulative totals in three pretty typical data science environments. All code and raw data is here. 
  

###Cumulative totals in Python

Python, like most programming languages, performs operations over rows of data sequentially, stopping when it hits a new column. (for example, it doesn't see data as a matrix, but more as individual values. ) 

This problem is easy to solve with Pandas, which transforms data once again into matrices that need to be operated on in their entirerty. These matrices are called data frames. But it's a little unwieldy when performing operations on operations on matrices, so  [you have to do](http://stackoverflow.com/questions/22650833/pandas-groupby-cumulative-sum) a cumulative sum of a cumulative sum: 



###Import Pandas for working with data


    import pandas as pd
    from pandas import DataFrame
    import dateutil.parser as parser


###Read in CSV file 


```df=pd.read_csv('sv.csv')```

```print df```

          Company   Month  New Employess
    0       Hooli  14-Jan         123456
    1       Hooli  14-Feb           1434
    2       Hooli  14-Mar           2455
    3  Pied Piper  14-Jan              1
    4  Pied Piper  14-Feb              2
    5  Pied Piper  14-Mar              2
    6      Raviga  14-Jan             50
    7      Raviga  14-Feb             48
    8      Raviga  14-Mar             65


###Make sure date and number values are rendered correctly from CSV file


```df['Month'] = pd.to_datetime(df['Month'])
    df.convert_objects(convert_numeric=True)```




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Company</th>
      <th>Month</th>
      <th>New Employess</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>      Hooli</td>
      <td>2015-01-14</td>
      <td> 123456</td>
    </tr>
    <tr>
      <th>1</th>
      <td>      Hooli</td>
      <td>2015-02-14</td>
      <td>   1434</td>
    </tr>
    <tr>
      <th>2</th>
      <td>      Hooli</td>
      <td>2015-03-14</td>
      <td>   2455</td>
    </tr>
    <tr>
      <th>3</th>
      <td> Pied Piper</td>
      <td>2015-01-14</td>
      <td>      1</td>
    </tr>
    <tr>
      <th>4</th>
      <td> Pied Piper</td>
      <td>2015-02-14</td>
      <td>      2</td>
    </tr>
    <tr>
      <th>5</th>
      <td> Pied Piper</td>
      <td>2015-03-14</td>
      <td>      2</td>
    </tr>
    <tr>
      <th>6</th>
      <td>     Raviga</td>
      <td>2015-01-14</td>
      <td>     50</td>
    </tr>
    <tr>
      <th>7</th>
      <td>     Raviga</td>
      <td>2015-02-14</td>
      <td>     48</td>
    </tr>
    <tr>
      <th>8</th>
      <td>     Raviga</td>
      <td>2015-03-14</td>
      <td>     65</td>
    </tr>
  </tbody>
</table>
</div>



###check each column's datatype


    
 ```print df.dtypes```

    Company                  object
    Month            datetime64[ns]
    New Employess           float64
    dtype: object



  ```print df.groupby(by=['Company','Month']).sum().groupby(level=[0]).cumsum()```

                           New Employess
    Company    Month                    
    Hooli      2015-01-14         123456
               2015-02-14         124890
               2015-03-14         127345
    Pied Piper 2015-01-14              1
               2015-02-14              3
               2015-03-14              5
    Raviga     2015-01-14             50
               2015-02-14             98
               2015-03-14            163 
               
               




##Cumulative Totals in R

R, in theory, operates on matrices, but it sees matrices in a pretty rigid, mathematical way, instead of the looser way they're implemented in databases. 

In order to do cumulative operations,   you can do this by converting your dataset to a more table-like format. (Check out [this link](http://stackoverflow.com/questions/22824662/calculate-cumulative-sum-of-one-column-based-on-another-columns-rank) for more detail on how to. )

```
sv <- read.csv("~/Desktop/ipythondata/sv.csv") #read in data
require(data.table) #package for transforming to data table
View(sv)
setDT (sv) #set the table as your dataset

setkey(sv, Company,Month) #sort in chronological order and groups
sv[,csum := cumsum(New.Employees),by=Company] #cumulative sum
View(sv) #view your results
```
![image](http://nancyfriedman.typepad.com/.a/6a00d8341c4f9453ef01a73dafb230970d-pi =400x300) 



##Cumulative Totals in SQL

This one is a little trickier because you have to start a database instance..somewhere. Usually, you'll have a dev environment to play around with at work. I have a Digital Ocean droplet that has Postgres installed. 


The reason this is so annoying is matrix operations. Most data-oriented languages and frameworks see groups of data as matrices, where an entire operation needs to be performed across the matrix (i.e. sum, )

