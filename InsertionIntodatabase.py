import pymysql
from datetime import datetime, timedelta

import re
import nltk

nltk.download('stopwords')

from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
ps = PorterStemmer()

all_stopwords = stopwords.words('english')
all_stopwords.remove('not')
import pickle

import document_similarity

from transformers import BertTokenizerFast,TFBertForSequenceClassification
import numpy as np
import tensorflow as tf
from transformers import TextClassificationPipeline

# Importing the transformer model
out_model_path = "Saved Models/BERT Classifier/"
model_path = out_model_path
tokenizer = BertTokenizerFast.from_pretrained(model_path, max_len=512, truncation=True)
tokenizer.model_max_length = 512
model = TFBertForSequenceClassification.from_pretrained(model_path, id2label={0: 'Non-Agriculture', 1: 'Agriculture'} ) # modify labels as needed.


sub_categories = {0: "OtherAgriNews", 1: "1_Government",
2: "2_Weather", 3: "3_International", 4: "4_Economic", 5: "5_Animal_Husbandry",
6: "6_Crop_Diseases_and_Protections", 7:"7_Technologies_and_Methods"}

time_cat = {0: "Not_Time_sensitive", 1: "Time_sensitive"}
sentiment_cat = {0: "Negative_sentiment", 1:"Positive_sentiment"}

			
print(f"Sub Categories:")
print(sub_categories)

model_sub_path = "Saved Models/BERT Subclassifier/"
tokenizer_sub = BertTokenizerFast.from_pretrained(model_sub_path, max_len=512, truncation=True)
tokenizer_sub.model_max_length = 512
model_sub = TFBertForSequenceClassification.from_pretrained(model_sub_path, id2label=sub_categories) # 

# Time Sensitive model
model_time_path = "Saved Models/Time/"
tokenizer_time = BertTokenizerFast.from_pretrained(model_time_path, max_len=512, truncation=True)
tokenizer_time.model_max_length = 512
model_time = TFBertForSequenceClassification.from_pretrained(model_time_path, id2label=time_cat) # 

# Sentiment model
model_sent_path = "Saved Models/Sentiment_analysis/"
tokenizer_sent= BertTokenizerFast.from_pretrained(model_sent_path, max_len=512, truncation=True)
tokenizer_sent.model_max_length = 512
model_sent = TFBertForSequenceClassification.from_pretrained(model_sent_path, id2label=sentiment_cat) # 




def is_agriculture_news(article_text):
    """
    Takes the article text and classifies whether the text is agriculture news or not
    """
    # load the model from disk
    vectorizer = pickle.load(open('Saved Models/vectorizer.pickel', 'rb'))
    classifier_model = pickle.load(open('Saved Models/classifier_model.pickel', 'rb'))


    # preprocessing
    review = re.sub('[^a-zA-Z]', ' ', article_text)
    review = review.lower()
    review = review.split()
    review = [ps.stem(word) for word in review if not word in set(all_stopwords)]
    review = ' '.join(review)
    review

    corpus = []
    corpus.append(review)

    X_fresh = vectorizer.transform(corpus).toarray()
    X_fresh.shape

    y_pred = classifier_model.predict(X_fresh)

    # 1 means agriculture news
    if y_pred==1:
        return True
    return False

def is_agriculture_news_transformer(article_text):
    # classification using transformers
    query = [article_text]
    pipe = TextClassificationPipeline(model=model, tokenizer=tokenizer, batch_size=1, device=-1)
    result = pipe(query, truncation=True)

    label = result[0]['label']
    if label == 'Agriculture':
        return True

    return False

def fetchArticlesForComparison(date):
    '''
        Fetches all articles for comparison from DB.
        IMP*: YOu can change no. of days for article comparison in predecessor_date
    '''
    connection = pymysql.connect('localhost', 'root', 'rootroot', 'AGRICULTURE_PORTAL')
    curr_date = datetime.strptime(date, '%y-%m-%d %H:%M:%S')
    successor_date = curr_date
    predecessor_date = curr_date - timedelta(days=30)		# Can change no. of days.
    result = None
    #print(predecessor_date, self.news_date, successor_date)
    sql = "SELECT * FROM NewsArticles WHERE NewsArticleDate BETWEEN %s AND %s"
    # sql = "SELECT * FROM NewsArticles LIMIT 2"

    try:
        db = connection.cursor()
        result = db.execute(sql, (predecessor_date, successor_date))
        # result = db.execute(sql)
        result = db.fetchall()
        connection.commit()

    except Exception as e:
        connection.rollback()

    finally:
        db.close()
        connection.close()

    return result


def is_duplicate(date, article_text):
    """
    Checks if the article is duplicate article and also if article length is >100 words
    """
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

    words = article_text.split(' ')
    if len(words) < 100:
        # ignore
        return True

    articles = fetchArticlesForComparison(date)
    database_articles_text_list = []
    for article in articles:
        articles_text_list =  article[2]
        database_articles_text_list.append(articles_text_list)
    
    # check for duplicate
    # if any of the article matches the current database then return True
    if len(database_articles_text_list) > 0:
        similar_articles_ind = document_similarity.get_similarity(database_articles_text_list, article_text)
        if len(similar_articles_ind) > 0:
            # there are similar articles in the database
            print("!!!!! Duplicate Article !!!!!")
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

            return True

    print("!!!!! Not Duplicate Article !!!!!")
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

    return False


# function to check the presence of a url in tabel
def IsUrlExists(url):
    '''
        TO check if URL exists in DB
        input: url - url of website
    '''
    connection = pymysql.connect(host = 'localhost', user = 'root', password = 'rootroot', db = 'AGRICULTURE_PORTAL')
    if all(ord(char) < 128 for char in url):
        sql = 'SELECT NewsArticleUrl from NewsArticles WHERE NewsArticleUrl Like %s'
        db = connection.cursor()
        db.execute(sql, ('%' + url + '%',))
        result = db.fetchall()
        db.close()
        connection.close()
        if result:
            return True
        else:
            return False
    else:
        return True 
        

# function to convert string date to datetime format
def return_date(date):
    '''
       To convert date into DB input format
    '''
    connection = pymysql.connect('localhost', 'root', 'rootroot', 'AGRICULTURE_PORTAL')
    tokens = date.split('T')
    tokens2 = tokens[1].split("+")
    date = tokens[0] + " " + tokens2[0]
    sql = "SELECT DATE_FORMAT(%s, '%%y-%%m-%%d %%h:%%i:%%s') as DATETIME;"
    db = connection.cursor()
    db.execute(sql, (date,))
    
    result = db.fetchall()
    db.close()
    connection.close()
    for res in result:    
        print(res)
        print(res[0])  
        return res[0]
        
def get_subclass(article_text):
    """
    Takes the article text and gives the sub-classfication of the agri news
    """
    query = [article_text]
    pipe = TextClassificationPipeline(model=model_sub, tokenizer=tokenizer_sub, batch_size=1, device=-1)
    result = pipe(query, truncation=True)

    label = result[0]['label']

    return label
    
def get_time_class(article_text):
    """
    Takes the article text and gives the time of the agri news
    """
    query = [article_text]
    pipe = TextClassificationPipeline(model=model_time, tokenizer=tokenizer_time, batch_size=1, device=-1)
    result = pipe(query, truncation=True)

    label = result[0]['label']

    return label

def get_sent_class(article_text):
    """
    Takes the article text and gives the sentiment of the agri news
    """
    query = [article_text]
    pipe = TextClassificationPipeline(model=model_sent, tokenizer=tokenizer_sent, batch_size=1, device=-1)
    result = pipe(query, truncation=True)

    label = result[0]['label']

    return label


# function to enter data into database.
def InsertIntoDatabase(date, url, title, text, location):
    print(date ,'\n', url,'\n' , title,'\n' , text,'\n' , location,'\n')
    
    new_date = date
    if date:
        new_date = return_date(date)
    else:
        new_date = datetime.datetime.now()
    
    connection = pymysql.connect('localhost', 'root', 'rootroot', 'AGRICULTURE_PORTAL')
    
    ########
    

    if is_agriculture_news_transformer(text) and not is_duplicate(new_date, text):
        
        sql = "INSERT INTO NewsArticles(NewsArticleTitle, NewsArticleText, NewsArticleDate, NewsArticleUrl, Location) values(%s, %s, %s, %s, %s)"
        
        sub_class = get_subclass(text)
        
        sql_sub = "INSERT INTO " + sub_class + "(NewsArticleTitle, NewsArticleText, NewsArticleDate, NewsArticleUrl, Location) values(%s, %s, %s, %s, %s)"

        ### Time-Sensitive and Sentiment-Analysis
        time_class = get_time_class(text)
        sent_class = get_sent_class(text)
        sql_time = "INSERT INTO " + time_class + "(NewsArticleTitle, NewsArticleText, NewsArticleDate, NewsArticleUrl, Location) values(%s, %s, %s, %s, %s)"
        sql_sent = "INSERT INTO " + sent_class + "(NewsArticleTitle, NewsArticleText, NewsArticleDate, NewsArticleUrl, Location) values(%s, %s, %s, %s, %s)"


        try:
            db = connection.cursor()
            print("date: ", new_date)
            if db.execute(sql, (title, text, new_date, url, location,)):
                rowId = connection.insert_id()
                print("Row id: ", rowId)
            
            # inserting in sub-classified tables
            if db.execute(sql_sub, (title, text, new_date, url, location,)):
                rowId = connection.insert_id()
                print(f"Sub-Class {sub_class}, Row id: {rowId}")

            # inserting in time classified tables
            if db.execute(sql_time, (title, text, new_date, url, location,)):
                rowId = connection.insert_id()
                print(f"Sub-Class {time_class}, Row id: {rowId}")

            # inserting in sub-classified tables
            if db.execute(sql_sent, (title, text, new_date, url, location,)):
                rowId = connection.insert_id()
                print(f"Sub-Class {sent_class}, Row id: {rowId}")
            
            connection.commit()
            db.close()
            connection.close()

            print("InsertionIntodatabase: Data Added")
        except Exception as e:

            # print(new_date)
            print("InsertionIntodatabase: There is some exception!")
            print(e)
            connection.rollback()
            connection.close()
