# shiny_project

###Shiny application with associated supporting documentation

#### Requirements
Write a shiny application with associated supporting documentation. 
The documentation should be thought of as whatever a user  will need to get started using your application.

  * Deploy the application on Rstudio's shiny server
  * Share the application link by pasting it into the text box below
  * Share your server.R and ui.R code on github

The application must include the following:

  - Some form of input (widget: textbox, radio button, checkbox, ...)
  - Some operation on the ui input in sever.R
  - Some reactive output displayed as a result of server calculations
  - You must also include enough documentation so that a novice user could use your application.
  - The documentation should be at the Shiny website itself. Do not post to an external link.

##Files
1. **UI.R**: This file contains the user-interface script.
2. **Server.R**:This file contains the server script.
3. **plot1.R**: This file creates the Working Directory (project) and download the required files from the web.
 
##Instructions
1. Open and execute the **plot1.R**, before open the **Server.R** and **ui.R** files.
  **NOTE**: Is required to download the repository: Dataset. 
  - From: [Project Files](https://d396qusza40orc.cloudfront.net/exdata/data/NEI_data.zip)
  - Creates a folder and call it: **project**.  This will be the working area.
  - Unzip the file **NEI_dataEDA.zip** into the folder **project**, and two files are unzipped: 
    - **summarySCC_PM25.rds**: PM2.5 Emissions Data - This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the =entire year. Here are the first few rows.  
    ``` 
      ##     fips      SCC Pollutant Emissions  type year
      ## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
      ## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
      ## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
      ## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
      ## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
      ## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
    ```
      -     **`fips`**: A five-digit number (represented as a string) indicating the U.S. county
      -     **`SCC`**: The name of the source as indicated by a digit string (see source code classification table)
      -     **`Pollutant`**: A string indicating the pollutant
      -     **`Emissions`**: Amount of PM2.5 emitted, in tons
      -     **`type`**: The type of source (point, non-point, on-road, or non-road)
      -     **`year`**: The year of emissions recorded
    - **Source_Classification_Code.rds**: Source Classification Code Table - This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.  Files are loaded using:
    ```
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    ```
2. Information has been loaded, then the **server.R** must be loaded and appears a new window containing the project interface.
3. **Interface**:
  - **`Side Bar Panel (sidebarPanel)`**: contains: 
    -  "Number of observations to view" **`textInput`**: quantity of observations to print in **`mainPanel`** in `<Observations table>`.
    - "Choose an Option" **`selectInput`**: to choose one question to be answered and plotted in the **`mainPanel`**.
  - **`Main Panel (mainPanel)`**: is the work area, as default appears all questions that are options on the **`selectInput`**.
4. Once one option is selected on the **`selectInput`**, after a short time calculating values, appears: 
  - The selected question.
  - The **`plot`** of the selected question.
  - The **`summary`** of the information that has been used.
  - The **`observations`** of the information that has been used.
 

##**QUESTIONS/OPTIONS TO BE ANSWERED**
1.  **`Question 1`**: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
    Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
    for each of the years 1999, 2002, 2005, and 2008.
    - **__`Answer 1`__**:
      - **Plot**:
      -
        ![Question1 Plot](/project/img/plot1.png)
      - **Summary**:
      
        ```
        fips               SCC             Pollutant           Emissions            type                year     
 Length:6497651     Length:6497651     Length:6497651     Min.   :     0.0   Length:6497651     Min.   :1999  
 Class :character   Class :character   Class :character   1st Qu.:     0.0   Class :character   1st Qu.:2002  
 Mode  :character   Mode  :character   Mode  :character   Median :     0.0   Mode  :character   Median :2005  
                                                          Mean   :     3.4                      Mean   :2004  
                                                          3rd Qu.:     0.1                      3rd Qu.:2008  
                                                          Max.   :646952.0                      Max.   :2008  
        ```
      - **Observations**
      
        ```
        	fips	SCC	Pollutant	Emissions	type	year
     4	09001	10100401	PM25-PRI	15.71	POINT	1999
     8	09001	10100404	PM25-PRI	234.18	POINT	1999
     12	09001	10100501	PM25-PRI	0.13	POINT	1999
     16	09001	10200401	PM25-PRI	2.04	POINT	1999
     20	09001	10200504	PM25-PRI	0.39	POINT	1999
     24	09001	10200602	PM25-PRI	1.49	POINT	1999
     28	09001	10200603	PM25-PRI	0.20	POINT	1999
     32	09001	10300401	PM25-PRI	0.08	POINT	1999
     36	09001	10300501	PM25-PRI	0.18	POINT	1999
     40	09001	10300504	PM25-PRI	0.27	POINT	1999
        ```
2.  **`Question 2`**: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
    from 1999 to 2008? Use the base plotting system to make a plot answering this question.
    - **__`Answer 2`__**:
      - **Plot**:
      
        ![Question2 Plot](/project/img/plot2.png)
      - **Summary**:
      
        ```
        fips               SCC             Pollutant           Emissions            type                year     
 Length:6497651     Length:6497651     Length:6497651     Min.   :     0.0   Length:6497651     Min.   :1999  
 Class :character   Class :character   Class :character   1st Qu.:     0.0   Class :character   1st Qu.:2002  
 Mode  :character   Mode  :character   Mode  :character   Median :     0.0   Mode  :character   Median :2005  
                                                          Mean   :     3.4                      Mean   :2004  
                                                          3rd Qu.:     0.1                      3rd Qu.:2008  
                                                          Max.   :646952.0                      Max.   :2008  
        ```
      - **Observations**
      
        ```
        	fips	SCC	Pollutant	Emissions	type	year
     4	09001	10100401	PM25-PRI	15.71	POINT	1999
     8	09001	10100404	PM25-PRI	234.18	POINT	1999
     12	09001	10100501	PM25-PRI	0.13	POINT	1999
     16	09001	10200401	PM25-PRI	2.04	POINT	1999
     20	09001	10200504	PM25-PRI	0.39	POINT	1999
     24	09001	10200602	PM25-PRI	1.49	POINT	1999
     28	09001	10200603	PM25-PRI	0.20	POINT	1999
     32	09001	10300401	PM25-PRI	0.08	POINT	1999
     36	09001	10300501	PM25-PRI	0.18	POINT	1999
     40	09001	10300504	PM25-PRI	0.27	POINT	1999
        ```
        
3.  **`Question 3`**: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
    which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
    Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system 
    to make a plot answer this question.
    - **__`Answer 3`__**:
      - **Plot**:
        
        ![Question3 Plot](/project/img/plot3.png)
      - **Summary**:
      
        ```
        fips               SCC             Pollutant           Emissions            type                year     
 Length:6497651     Length:6497651     Length:6497651     Min.   :     0.0   Length:6497651     Min.   :1999  
 Class :character   Class :character   Class :character   1st Qu.:     0.0   Class :character   1st Qu.:2002  
 Mode  :character   Mode  :character   Mode  :character   Median :     0.0   Mode  :character   Median :2005  
                                                          Mean   :     3.4                      Mean   :2004  
                                                          3rd Qu.:     0.1                      3rd Qu.:2008  
                                                          Max.   :646952.0                      Max.   :2008  
        ```
        - **Observations**
        
        ```
        	fips	SCC	Pollutant	Emissions	type	year
     4	09001	10100401	PM25-PRI	15.71	POINT	1999
     8	09001	10100404	PM25-PRI	234.18	POINT	1999
     12	09001	10100501	PM25-PRI	0.13	POINT	1999
     16	09001	10200401	PM25-PRI	2.04	POINT	1999
     20	09001	10200504	PM25-PRI	0.39	POINT	1999
     24	09001	10200602	PM25-PRI	1.49	POINT	1999
     28	09001	10200603	PM25-PRI	0.20	POINT	1999
     32	09001	10300401	PM25-PRI	0.08	POINT	1999
     36	09001	10300501	PM25-PRI	0.18	POINT	1999
     40	09001	10300504	PM25-PRI	0.27	POINT	1999
        ```

**NOTE**: These points are part of a project that is part of the **__Exploratory Data Analysis__** course, that is part of the **Data Scientist** Specialization.  And this project has been used as part of the **__Developing Data Products__** project.
