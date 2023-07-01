/* Case Study: Prepare World Tourism Data */

/* Please see the README.md for case study description */


/* 1. Redefine the cr library */
libname cr "~/ECRB94/data";

/* 2. Read the cr.tourism table and create the temporary cleaned_tourism table. */
data cleaned_tourism (where = (A = . AND COUNTRY NOT IN ('Inbound tourism', 'Outbound tourism')));
set cr.tourism;
/* 3. remove columns _1995 - _2013 */
drop _1995-_2013;
/* 4. Create Country_Name and Tourism_Type columns from values in the COUNTRY column */
retain Country_Name Tourism_Type;
IF A ^= . THEN Country_Name = COUNTRY;
IF COUNTRY IN ('Inbound tourism', 'Outbound tourism') THEN Tourism_Type = COUNTRY;
/* 5. In the Series column, convert values to uppercase and convert ".." to missing a character value. */
Series = UPCASE(Series);
IF Series = '..' THEN Series = '';
/* 6. Create a new column Y2014 */
IF findw(COUNTRY, ' Thousands') THEN unit = 1000;
ELSE IF findw(COUNTRY, 'US$ Mn') THEN unit = 1000000;   
IF _2014 = '..' THEN _2014 = '.';
Y2014 = INPUT(_2014, 6.) * unit;
/* 7. Create a new column Category */
length Category$ 47;
Category = TRIM(LEFT(SCAN(COUNTRY, 1, '-')));
IF Category NOT IN ('Arrivals', 'Departures') THEN Category = CATX(' - ', Category, 'US$');
/* 8. Format Y2014 with COMMA format */
format Y2014 comma20.;
run;

/* 9. Write the cleaned_tourism table into cr.cleaned_tourism and only include Country_Name, Tourism_Type, Category, Series, and Y2014 */
data cr.cleaned_tourism;
set cleaned_tourism;
keep Country_Name Tourism_Type Category Series Y2014;
run;

/* 10. Create a format for the Continent column that labels continent IDs with the corresponding continent names */
proc format;
value CONTFMT 1 = 'North America'
	          2 = 'South America'
	          3 = 'Europe'
	          4 = 'Africa'
	          5 = 'Asia'
	          6 = 'Oceania'
	          7 = 'Antarctica';
run;

 
/* 11. Merge the cleaned_tourism table with a sorted version of country_info to create the final_tourism table. 
	   Include only matches in the output table. Use the new format to format Continent */
proc sort data = cr.cleaned_tourism out = cleaned_tourism;
by Country_Name;
run;

proc sort data = cr.country_info(rename = (Country = Country_Name)) out = country_info;
by Country_Name;
run;

data cr.final_tourism;
merge cleaned_tourism(in = A) country_info(in = B);
by Country_Name;
IF A = 1 AND B = 1;
format Continent CONTFMT.;
run;

proc print data = cr.final_tourism;
run;


/* 12. Create the NoCountryFound table that has a list of countries from cleaned_tourism that are not found in the country_info table.
   	   This table should have only one row for each country. */
data NoCountryFound(keep = Country_Name);
merge cleaned_tourism(in = A) country_info(in = B);
by Country_Name;
IF A = 1 AND B = 0;
run;

proc sort data = NoCountryFound NODUPKEY;
BY Country_Name;
run;

proc print data = NoCountryFound;
run;




/* 
  Analyze the number of arrivals in 2014 for each continent. 
  Generate mean, minimum, and maximum statistics, rounded to the nearest whole number. 
*/
proc means data= cr.final_tourism(where = (Category = 'Arrivals')) maxdec = 0 mean min max;
var Y2014;
class Continent;
run;

/* 
  Generate an overall mean (rounded to the nearest whole number) for tourism expenditure in other countries.
 */
proc means data = cr.final_tourism(where = (Category = 'Tourism expenditure in other countries - US$')) MAXDEC = 0 mean;
var Y2014;
run;



