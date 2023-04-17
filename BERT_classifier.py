from transformers import BertTokenizerFast,TFBertForSequenceClassification
import numpy as np
import tensorflow as tf
from transformers import TextClassificationPipeline

out_model_path = "Saved Models/BERT Classifier/"
model_path = out_model_path
tokenizer = BertTokenizerFast.from_pretrained(model_path)
model = TFBertForSequenceClassification.from_pretrained(model_path, id2label={0: 'Non-Agriculture', 1: 'Agriculture'} ) # modify labels as needed.

text = ["The results of the elections appear to favour candidate obasangjo",
        "Seed quality if low",
        "Apple production is not optimal this year"]

query = ["The results of the elections appear to favour candidate obasangjo"]
pipe = TextClassificationPipeline(model=model, tokenizer=tokenizer, batch_size=1, device=-1)
result = pipe(query)

print(result)
print(result[0]['label'])