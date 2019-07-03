# Log_Parser

## Context
This is a tech test to write a programme to  
• receive a log file as an argument  
• return a list of webpages in descending order of page visits   
• return a list of webpages in descending order of unique page views

## Tech Stack
• Language: Ruby  
• Test Framework: Rspec  
• Test Coverage: Simplecov  
• Linter: Rubocop  

## How to Run
From the terminal:  
• git clone this repository  
• navigate into the project repository  
• bundle install  
• run the application:
```
 ruby parser_app.rb webserver.log
```

## How to Test
From the terminal, within the project repository, run:
```
 rspec
```

Feature test by running the programme on the test.log:

```
ruby parser_app.rb ./spec/test.log
```

## Test Coverage
```
 COVERAGE: 100.00% -- 147/147 lines in 4 files
```

## Sreenshot
![image](https://user-images.githubusercontent.com/47269063/60589506-95c44f00-9d91-11e9-9ce0-40dd55666f91.png)

## Process

### User Stories

1. As a user  
   So I can analyse the webpage viewing history  
   I want to be able to read the web server log

2. As a user   
   So I can analyse the webpage viewing history  
   I wan to be able to list the webpages from most page visits to less page visits  

3. As a user   
   So I can analyse the webpage viewing history   
   I wan to be able to list the webpages from most unique page views to less unique page views  

4. As a user   
   So I can see the results of analysis  
   I want to be able to print the list of webpages in descending order of page visits

5. As a user  
   So I can see the results of analysis   
   I want to be able to print the list of webpages in descending order of unique page views

6. As a user   
   So I can analysis any web server history   
   I want to be able to input the web server log file name as a argument to run the programme  

### Object Model (CRC card)

**Parser:**

Responsibilities | Collaborators
------------- | ------------------
read_log |
order_by_visits |
order_by_uniq_views |
print_list_of_visits | Printer
print_list_of_unique_views | Printer

**Printer:**

Responsibilities | Collaborators
------------- | ------------------
print_in_visits_format |
print_in_unique_views_format |

### Edge Cases
Following edge cases have been tested:  
• log file does not exist or filename is wrong    
• log file is empty   
• print the singular visit/view when there is only one visit/view to the webpage    

### Extra Feature
When two urls having same amount of page visits or unique views, they will be listed in alphabetical order
