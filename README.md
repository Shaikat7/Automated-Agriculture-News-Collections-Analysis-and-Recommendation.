
# Agriculture_News_Portal

In this project, we collect news articles from various news sites and classify articles to check between agriculture and non-agriculture. Also, we are checking duplicate articles in this process. Then subclassification have been done between seven categories of agriculture articles. And finally, based on content, recommendations like sentiment analysis of articles and time sensitivity analysis will be provided. A website to get all the agriculture news in one place so quiickly.

#### --Crawler used to collect data automatically from news sites

#### --BERT is used in classification, subclassification, and recommendation processes. 



## To Run this project following things need to do:

1. This program runs in **Ubuntu**.
2. First of all database need to create. For database we have used My SQL. All the queries to create the database are given in **Queries** folder.
3. Make one new folder and download all files & folders given here. Keep all the files & folders in that folder. In this place create a folder with name - **Saved Models** and put all the save models in this folder. This should be done properly to keep the path same.
4. Need to download all the **Saved models**. Link is given here-

```bash
  https://drive.google.com/drive/folders/1_RT_T9TQXS1yq6lOwM1sB4uSOojpxpbJ?usp=sharing
```
5. You can change your database user id and password from the **insertionintodatabase.py** file. 
6. To run transformer, it needs to install. Copy & paste the following commands in terminal to install transformer. 
```bash
  pip install transformers
```
```bash
  pip install tensorflow
```
7. Other packages need to be installed as required by the system. If the system shows to install something, then Install all the packages.

8. After the proper setup, **crawler.py** files need to run to crawl news articles, and it will automatically save the data in the database. So, there will be all agriculture news in the database, and many subcategories of news will be there. 

#### By running crawler.py, it will run for crawler,classification, sub-classification,duplication, and recommendation all together. All the program is set in one file.####

Run the following command in terminal to run the crawler.py file. 
```bash
  python crawler.py
```
Or 
```bash
  python3 crawler.py
```
9. Crawled data can be seen in any database user interface. For example, you can download "dbeaver-ce" software in your system and connect it to your database. 

## Folders and files description:
1. All classification codes are given in the **All_classification_code** folder you can have a look. 
2. In **NewsSiteCrawler** folder all the news sites crawling code has been provided. 
3. Saved Models can not be share for large size. So It needs to be download from the given link. 
