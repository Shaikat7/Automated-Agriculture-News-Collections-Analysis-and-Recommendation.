# Code by Shaikat Das Joy

import re

import nltk
nltk.download('punkt')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize

from nltk.stem import WordNetLemmatizer
from nltk.tokenize import word_tokenize
import nltk
nltk.download('wordnet')
nltk.download('stopwords')
nltk.download('omw-1.4')

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

def lowerText(text):
  text = text.lower()
  return text

def removePunctuation(string): 
    punctuations = '''!()-[]{};:'"\,<>./?@#$%^&*_~'''
    for x in string.lower(): 
        if x in punctuations: 
            string = string.replace(x, "") 
    return string

def removeNumbers(text):
  input_str = re.sub(r'\d+', "", text)
  return input_str


def removeWhitespace(input_str):
    # To remove leading and ending spaces, you can use the strip() function
    input_str = input_str.strip()

    return input_str


def removeStopwords(text):
  stop_words = set(stopwords.words('english'))
  tokens = word_tokenize(text)
  result = [i for i in tokens if not i in stop_words]
  return " ".join(result)


def lemmatization(text):
  tokens = []
  lemmatizer=WordNetLemmatizer()
  input_str=word_tokenize(text)
  for word in input_str:
      tokens.append(lemmatizer.lemmatize(word))
  return " ".join(tokens)


def preprocess_text(text):
    text = lowerText(text)
    text = removePunctuation(text)
    text = removeNumbers(text)
    text = removeWhitespace(text)
    text = removeStopwords(text)
    text = lemmatization(text)
    return text


def get_similarity(articles, query_text):
    # returns the index of the similar articles
    # Note check the THRESHOLD

    document_list_processed = []
    for text in articles:
        document_list_processed.append(preprocess_text(text))

    vectorizer = TfidfVectorizer(max_df=0.8, min_df=0.2, max_features=1000, stop_words={'english'})
    X = vectorizer.fit_transform(document_list_processed)

    query_text_preprocessed = preprocess_text(query_text)


    ## Calculate the similarity for each of the documents

    query_vector = vectorizer.transform([query_text_preprocessed])
    # Calculate the cosine similarity between the vector of each document and the query vector
    results = cosine_similarity(X, query_vector)
    results = results.reshape((-1,))

    # Tune the threshold according to the similarity you want in the article
    # The similarity scores will be in the range [0, 1]
    THRESHOLD = 0.8

    similar_articles_index = []
    for i, sim_score in enumerate(results):
        if sim_score > THRESHOLD:
            similar_articles_index.append(i)
    
    return similar_articles_index
