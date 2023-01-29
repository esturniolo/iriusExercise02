# index.py
import json
import boto3
from collections import Counter

def lambda_handler(event, context):
    text = event['text']

    # tokenize the text
    tokens = text.split()

    # create a frequency list of the tokens
    frequency_list = Counter(tokens)

    # sort the frequency list by descending order of count
    sorted_frequency_list = dict(sorted(frequency_list.items(), key=lambda item: item[1], reverse=True))

    # take the top 10 words
    top10 = dict(list(sorted_frequency_list.items())[:10])

    # format the data as a JSON object
    data = json.dumps(top10)

    # upload the JSON file to S3
    s3 = boto3.client('s3')
    s3.put_object(Bucket='my-bucket', Key='top10.json', Body=data)

    # return the URL to download the file
    return {
        'statusCode': 200,
        'body': f'https://my-bucket.s3.amazonaws.com/top10.json'
    }
