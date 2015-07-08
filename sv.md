
##Import Pandas for working with data


    import pandas as pd
    from pandas import DataFrame
    import dateutil.parser as parser


##Read in CSV file 


     df=pd.read_csv('sv.csv')


    print df

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


##Make sure date and number values are rendered correctly from CSV file


    
    df['Month'] = pd.to_datetime(df['Month'])
    df.convert_objects(convert_numeric=True)




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



##check each column's datatype


    
    print df.dtypes

    Company                  object
    Month            datetime64[ns]
    New Employess           float64
    dtype: object



    print df.groupby(by=['Company','Month']).sum().groupby(level=[0]).cumsum()

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

