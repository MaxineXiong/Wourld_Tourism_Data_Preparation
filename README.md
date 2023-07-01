# **SAS Case Study: World Tourism Data Preparation**
[![GitHub](https://badgen.net/badge/icon/GitHub?icon=github&color=black&label)](https://github.com/MaxineXiong)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SAS - >= 9.4](https://img.shields.io/badge/SAS->=_9.4-008DE4)](https://support.sas.com/software/94/)

<br>

In this case study, the primary objective is to organize and prepare data for a company, enabling the analyst team to generate insightful reports, visualizations, and statistical models aimed at expanding the company's market share. Specifically, the focus is on analyzing inbound and outbound tourism data for countries and continents in the year 2014. The project involves three overall tasks related to the delivery of essential tables: the **cleaned_tourism** table, the **final_tourism** table, and the **nocountryfound** table. The first task entails restructuring the initial **tourism** table to meet specific data requirements and creating the **cleaned_tourism** table. Subsequently, the second task involves merging the restructured tourism data with the **country-info** table to establish the **final_tourism** table, which exclusively contains matching rows. Finally, the third task necessitates creating the **nocountryfound** table, containing a distinct list of countries that lack matching rows in the **country_info** table. The SAS program has effectively addressed these data requirements.

<br>

## Case Study Requirements

The **raw data** for this case study is the **Tourism** data located in **CR** library.

![screenshot1](https://github.com/MaxineXiong/Wourld_Tourism_Data_Preparation/assets/55864839/cd59c0aa-c5e8-4947-ad7b-ca7f9c978a0d)

The final table should be a combination of the **cleaned_tourism** table and the **country_info** table.

See the example of **desired outcome** below:

![screenshot2](https://github.com/MaxineXiong/Wourld_Tourism_Data_Preparation/assets/55864839/25eea279-ea1b-48c9-8231-3081129fc3cf)

### Data Requirements

Create the **cleaned_tourism** table with the following column requirements:

- **Country_Name** – contains the country name from the original Country column.
- **Tourism_Type** – contains the type of tourism from the original Country column. Valid values are Inbound tourism or Outbound tourism.
- **Category** – contains category names by extracting and modifying values from the original **Country** column. There should be six distinct values for **Category** as shown in the table below:

<img src = 'https://github.com/MaxineXiong/Wourld_Tourism_Data_Preparation/assets/55864839/4ffaa71f-fe83-4c5a-a764-2b1a7de5704f' width = 800></img>

- **Series** – All values should be in uppercase and data that is not available (coded as "..") should be changed to a missing character value.
- **Y2014** – contains numeric values that are calculated from the scaled character values in the original **_2014** year column. The scaled values are multiplied by either thousands or millions (abbreviated Mn), depending on the value listed for category in the Country column. The new **Y2014** values should be formatted with the COMMA format.
    - Example: if the category is **Travel - US$ MN** and the value for **_2014** is 4.26, **Y2014** is equal to 4.26 * 1000000, or 4,260,000.
    - Include only **Country_Name**, **Tourism_Type**, **Category**, **Series**, and **Y2014** in the output table.

<br>

Merge the **cleaned_tourism** table with the **country_info** table and do the following:

1. Create two new tables: 
    - **final_tourism** should contain **only** merged data.
    - **nocountryfound** should contain a list of distinct countries from the **cleaned_tourism** table that do not have a match in the **country_info** table.
2. Create a format for the **Continent** column that labels continent IDs with the corresponding continent names. Permanently apply the format in the **final_tourism** table.
    - 1 = North America
    - 2 = South America
    - 3 = Europe
    - 4 = Africa
    - 5 = Asia
    - 6 = Oceania
    - 7 = Antarctica

<br>

## **Repository Structure**

This repository is structured as follows:

```
TSA-Claims-Data-Analysis 
├── World_Tourism_Data_Preparation.sas 
├── ECRB94/ 
│   └── createdataCRB_oda.sas 
├── README.md 
└── LICENSE
```

- **World_Tourism_Data_Preparation.sas**: This SAS program file addresses all data requirements in the case study. It is the main file for preparing and analysing the tourism data for inbound and outbound 2014 tourism for countries and continents.
- **ECRB94/createdataCRB_oda.sas**: This SAS program generates all the necessary libraries, tables, and data files in SAS Studio. It sets up the required environment for running the main data preparation program, **World_Tourism_Data_Preparation.sas**.
- **README.md**: This file provides an overview of the repository, including descriptions of the case study and relevant information for usage.
- **LICENSE**: The license file for the project.

Please note that the **World_Tourism_Data_Preparation.sas** program should be used as the primary entry point for data preparation, while **ECRB94/createdataCRB_oda.sas** sets up the required environment to execute the data preparation program successfully.

<br>

## Prerequisites

To run the TSA Claims Data Analysis program, you need an active account for either [**SAS® OnDemand for Academics**](https://welcome.oda.sas.com/) or **[SAS® Viya](https://www.sas.com/en_au/software/viya.html)**. These platforms provide the necessary environment for executing SAS programs and analysing the data.

<br>

## **Usage**

To use this repository, follow the steps outlined below:

1. Download the repository to your local machine.
2. Launch **SAS Studio** using your SAS software.
3. In the **Server Files and Folders** panel, click **New** at the top and select **Folder**.
4. Enter "**ECRB94**" in uppercase exactly as shown in the **Name** box. Click **Save**.
5. Verify that the **ECRB94** folder has been successfully created under **Files(Home)**.
6. Select the **ECRB94** folder and click the **Upload** tool.
7. In the Upload Files window, click **Choose Files** and navigate to the **ECRB94** folder on your computer. Select the file **createdataCRB_oda.sas** and click **Open**. Click **Upload** to add the program to the **ECRB94** folder on the server.
8. In SAS Studio, double-click **createdataCRB_oda.sas** to open the program.
9. Click the **Run** tool or press **F3** to execute the program. This will generate all the necessary SAS files and data required for the program. After the program completes, you will see a list of SAS tables displayed in the Results tab.
10. In the Server Files and Folders panel, navigate to the **ECRB94** folder and collapse each subfolder. You should see three subfolders: **data**, **output**, and **programs**.
11. The target libraries and tables used in the SAS program are now accessible in the **~/ECRB94/data** directory.

By following these steps, you will have successfully set up the required environment and data files to utilize the SAS program included in this repository.

<br>

## **License**

This project is licensed under the **[MIT License](https://choosealicense.com/licenses/mit/)**.
