

```python
# Dependencies
import tweepy
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import seaborn as sns
import json
from datetime import datetime

# Import and Initialize Sentiment Analyzer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Twitter API Keys
consumer_key = "74jUwUd71lal3P12lL3RTBYks"
consumer_secret = "vh2HfHinkoEFuYz3rqptBTNEmgaxyKFCxWF5Jszq9iilhRlMyJ"
access_token = "930162277730406400-O2vqU07snMEa5M1YRxjHT3n96FA6JqP"
access_token_secret = "Yw2y9gRnAOvLNMo1XQ76udJyRFfchCM8Ob6RIQty8GlpI"

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())
```


```python
# Target Account
target_users = ["@BBCWorld", "@CBSNews", "@CNN", "@FoxNews", "@nytimes"]


# Variables for holding sentiments
sentiments = []

for target_user in target_users:
    counter = 100
# Loop through 5 pages of tweets (total 100 tweets)
    for x in range(5):

    # Get all tweets from home feed
        public_tweets = api.user_timeline(target_user,page=x)

    # Loop through all tweets 
        for tweet in public_tweets:

        # Print Tweets
        # print("Tweet %s: %s" % (counter, tweet["text"]))
            #print("processing "+target_user)  
        # Run Vader Analysis on each tweet
            results = analyzer.polarity_scores(tweet["text"])
            compound = results["compound"]
            pos = results["pos"]
            neu = results["neu"]
            neg = results["neg"]
            tweets_ago = counter
            
            Date = str(datetime.strptime(tweet["created_at"], "%a %b %d %H:%M:%S %z %Y"))
            Date = Date[:19]
            
        # Add sentiments for each tweet into an array
            sentiments.append({"Date": tweet["created_at"], 
                           "Compound": compound,
                           "Positive": pos,
                           "Negative": neu,
                           "Neutral": neg,
                           "Tweets Ago": counter,
                            "source":tweet["user"]["screen_name"]})
        
        # Add to counter 
            counter = counter - 1
```


```python
#create dataframe for the sentiment data
sentiments_pd = pd.DataFrame.from_dict(sentiments)
sentiments_pd
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Compound</th>
      <th>Date</th>
      <th>Negative</th>
      <th>Neutral</th>
      <th>Positive</th>
      <th>Tweets Ago</th>
      <th>source</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-0.6808</td>
      <td>Sat Dec 02 16:49:32 +0000 2017</td>
      <td>0.556</td>
      <td>0.444</td>
      <td>0.000</td>
      <td>100</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.2263</td>
      <td>Sat Dec 02 15:45:18 +0000 2017</td>
      <td>0.826</td>
      <td>0.174</td>
      <td>0.000</td>
      <td>99</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.5106</td>
      <td>Sat Dec 02 15:19:34 +0000 2017</td>
      <td>0.680</td>
      <td>0.000</td>
      <td>0.320</td>
      <td>98</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.8316</td>
      <td>Sat Dec 02 15:01:56 +0000 2017</td>
      <td>0.585</td>
      <td>0.415</td>
      <td>0.000</td>
      <td>97</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>4</th>
      <td>-0.4576</td>
      <td>Sat Dec 02 13:20:58 +0000 2017</td>
      <td>0.700</td>
      <td>0.300</td>
      <td>0.000</td>
      <td>96</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.9081</td>
      <td>Sat Dec 02 12:41:25 +0000 2017</td>
      <td>0.625</td>
      <td>0.000</td>
      <td>0.375</td>
      <td>95</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.0000</td>
      <td>Sat Dec 02 12:38:18 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>94</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.4404</td>
      <td>Sat Dec 02 12:12:08 +0000 2017</td>
      <td>0.674</td>
      <td>0.000</td>
      <td>0.326</td>
      <td>93</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.0000</td>
      <td>Sat Dec 02 11:58:23 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>92</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>9</th>
      <td>0.0000</td>
      <td>Sat Dec 02 11:31:35 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>91</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.2500</td>
      <td>Sat Dec 02 10:53:36 +0000 2017</td>
      <td>0.625</td>
      <td>0.159</td>
      <td>0.216</td>
      <td>90</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.5719</td>
      <td>Sat Dec 02 10:34:23 +0000 2017</td>
      <td>0.748</td>
      <td>0.000</td>
      <td>0.252</td>
      <td>89</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>12</th>
      <td>0.0000</td>
      <td>Sat Dec 02 10:06:52 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>88</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>13</th>
      <td>-0.3400</td>
      <td>Sat Dec 02 09:43:41 +0000 2017</td>
      <td>0.676</td>
      <td>0.324</td>
      <td>0.000</td>
      <td>87</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>14</th>
      <td>0.0000</td>
      <td>Sat Dec 02 09:09:59 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>86</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>15</th>
      <td>-0.6808</td>
      <td>Sat Dec 02 08:14:57 +0000 2017</td>
      <td>0.517</td>
      <td>0.483</td>
      <td>0.000</td>
      <td>85</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.0000</td>
      <td>Sat Dec 02 08:02:35 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>84</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.0000</td>
      <td>Sat Dec 02 06:59:38 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>83</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.3612</td>
      <td>Sat Dec 02 05:05:41 +0000 2017</td>
      <td>0.706</td>
      <td>0.000</td>
      <td>0.294</td>
      <td>82</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>19</th>
      <td>0.3182</td>
      <td>Sat Dec 02 02:15:36 +0000 2017</td>
      <td>0.777</td>
      <td>0.000</td>
      <td>0.223</td>
      <td>81</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>20</th>
      <td>-0.6808</td>
      <td>Sat Dec 02 16:49:32 +0000 2017</td>
      <td>0.556</td>
      <td>0.444</td>
      <td>0.000</td>
      <td>80</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>21</th>
      <td>-0.2263</td>
      <td>Sat Dec 02 15:45:18 +0000 2017</td>
      <td>0.826</td>
      <td>0.174</td>
      <td>0.000</td>
      <td>79</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>22</th>
      <td>0.5106</td>
      <td>Sat Dec 02 15:19:34 +0000 2017</td>
      <td>0.680</td>
      <td>0.000</td>
      <td>0.320</td>
      <td>78</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>23</th>
      <td>-0.8316</td>
      <td>Sat Dec 02 15:01:56 +0000 2017</td>
      <td>0.585</td>
      <td>0.415</td>
      <td>0.000</td>
      <td>77</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>24</th>
      <td>-0.4576</td>
      <td>Sat Dec 02 13:20:58 +0000 2017</td>
      <td>0.700</td>
      <td>0.300</td>
      <td>0.000</td>
      <td>76</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>25</th>
      <td>0.9081</td>
      <td>Sat Dec 02 12:41:25 +0000 2017</td>
      <td>0.625</td>
      <td>0.000</td>
      <td>0.375</td>
      <td>75</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>26</th>
      <td>0.0000</td>
      <td>Sat Dec 02 12:38:18 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>74</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>27</th>
      <td>0.4404</td>
      <td>Sat Dec 02 12:12:08 +0000 2017</td>
      <td>0.674</td>
      <td>0.000</td>
      <td>0.326</td>
      <td>73</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>28</th>
      <td>0.0000</td>
      <td>Sat Dec 02 11:58:23 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>72</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>29</th>
      <td>0.0000</td>
      <td>Sat Dec 02 11:31:35 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>71</td>
      <td>BBCWorld</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>470</th>
      <td>0.0000</td>
      <td>Sat Dec 02 05:34:03 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>30</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>471</th>
      <td>0.0000</td>
      <td>Sat Dec 02 05:32:05 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>29</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>472</th>
      <td>0.2263</td>
      <td>Sat Dec 02 05:19:13 +0000 2017</td>
      <td>0.913</td>
      <td>0.000</td>
      <td>0.087</td>
      <td>28</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>473</th>
      <td>0.0000</td>
      <td>Sat Dec 02 05:14:09 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>27</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>474</th>
      <td>0.1531</td>
      <td>Sat Dec 02 05:02:06 +0000 2017</td>
      <td>0.693</td>
      <td>0.139</td>
      <td>0.168</td>
      <td>26</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>475</th>
      <td>-0.5106</td>
      <td>Sat Dec 02 04:48:43 +0000 2017</td>
      <td>0.708</td>
      <td>0.292</td>
      <td>0.000</td>
      <td>25</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>476</th>
      <td>0.1027</td>
      <td>Sat Dec 02 04:47:06 +0000 2017</td>
      <td>0.806</td>
      <td>0.089</td>
      <td>0.105</td>
      <td>24</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>477</th>
      <td>0.7096</td>
      <td>Sat Dec 02 04:32:07 +0000 2017</td>
      <td>0.688</td>
      <td>0.000</td>
      <td>0.312</td>
      <td>23</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>478</th>
      <td>0.2023</td>
      <td>Sat Dec 02 04:25:14 +0000 2017</td>
      <td>0.833</td>
      <td>0.000</td>
      <td>0.167</td>
      <td>22</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>479</th>
      <td>0.5994</td>
      <td>Sat Dec 02 04:10:55 +0000 2017</td>
      <td>0.754</td>
      <td>0.000</td>
      <td>0.246</td>
      <td>21</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>480</th>
      <td>0.2023</td>
      <td>Sat Dec 02 04:02:28 +0000 2017</td>
      <td>0.886</td>
      <td>0.000</td>
      <td>0.114</td>
      <td>20</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>481</th>
      <td>0.0000</td>
      <td>Sat Dec 02 03:47:02 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>19</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>482</th>
      <td>0.0000</td>
      <td>Sat Dec 02 03:32:07 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>18</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>483</th>
      <td>0.0000</td>
      <td>Sat Dec 02 03:17:03 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>17</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>484</th>
      <td>-0.5106</td>
      <td>Sat Dec 02 03:02:04 +0000 2017</td>
      <td>0.807</td>
      <td>0.193</td>
      <td>0.000</td>
      <td>16</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>485</th>
      <td>-0.2500</td>
      <td>Sat Dec 02 02:47:01 +0000 2017</td>
      <td>0.747</td>
      <td>0.155</td>
      <td>0.098</td>
      <td>15</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>486</th>
      <td>0.0000</td>
      <td>Sat Dec 02 02:31:10 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>14</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>487</th>
      <td>0.0000</td>
      <td>Sat Dec 02 02:16:05 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>13</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>488</th>
      <td>0.2023</td>
      <td>Sat Dec 02 02:00:24 +0000 2017</td>
      <td>0.909</td>
      <td>0.000</td>
      <td>0.091</td>
      <td>12</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>489</th>
      <td>0.4019</td>
      <td>Sat Dec 02 01:47:03 +0000 2017</td>
      <td>0.886</td>
      <td>0.000</td>
      <td>0.114</td>
      <td>11</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>490</th>
      <td>-0.5719</td>
      <td>Sat Dec 02 01:32:06 +0000 2017</td>
      <td>0.773</td>
      <td>0.227</td>
      <td>0.000</td>
      <td>10</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>491</th>
      <td>-0.8225</td>
      <td>Sat Dec 02 01:17:04 +0000 2017</td>
      <td>0.625</td>
      <td>0.375</td>
      <td>0.000</td>
      <td>9</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>492</th>
      <td>0.0000</td>
      <td>Sat Dec 02 01:01:44 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>8</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>493</th>
      <td>-0.0772</td>
      <td>Sat Dec 02 00:47:03 +0000 2017</td>
      <td>0.736</td>
      <td>0.141</td>
      <td>0.123</td>
      <td>7</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>494</th>
      <td>-0.4215</td>
      <td>Sat Dec 02 00:32:07 +0000 2017</td>
      <td>0.763</td>
      <td>0.237</td>
      <td>0.000</td>
      <td>6</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>495</th>
      <td>0.0000</td>
      <td>Sat Dec 02 00:17:04 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>5</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>496</th>
      <td>0.0000</td>
      <td>Sat Dec 02 00:02:08 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>4</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>497</th>
      <td>0.0000</td>
      <td>Fri Dec 01 23:47:04 +0000 2017</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>3</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>498</th>
      <td>-0.0258</td>
      <td>Fri Dec 01 23:32:12 +0000 2017</td>
      <td>0.686</td>
      <td>0.160</td>
      <td>0.154</td>
      <td>2</td>
      <td>nytimes</td>
    </tr>
    <tr>
      <th>499</th>
      <td>0.2023</td>
      <td>Fri Dec 01 23:17:05 +0000 2017</td>
      <td>0.705</td>
      <td>0.122</td>
      <td>0.173</td>
      <td>1</td>
      <td>nytimes</td>
    </tr>
  </tbody>
</table>
<p>500 rows × 7 columns</p>
</div>




```python
bbc_tweets = sentiments_pd[sentiments_pd["source"] == "BBCWorld"]
cbs_tweets = sentiments_pd[sentiments_pd["source"] == "CBSNews"]
cnn_tweets = sentiments_pd[sentiments_pd["source"] == "CNN"]
fox_tweets = sentiments_pd[sentiments_pd["source"] == "FoxNews"]
nyt_tweets = sentiments_pd[sentiments_pd["source"] == "nytimes"]
```


```python
#create the scatter plot
plt.scatter(bbc_tweets["Tweets Ago"],bbc_tweets["Compound"], 
            s=50, c="coral", 
            edgecolor="black", linewidths=1, marker="o", 
            alpha=0.8, label="BBC")

plt.scatter(cbs_tweets["Tweets Ago"],cbs_tweets["Compound"], 
            s=50, c="blue", 
            edgecolor="black", linewidths=1, marker="o", 
            alpha=0.8, label="CBS")

plt.scatter(cnn_tweets["Tweets Ago"],cnn_tweets["Compound"], 
            s=50, c="red", 
            edgecolor="black", linewidths=1, marker="o", 
            alpha=0.8, label="CNN")

plt.scatter(fox_tweets["Tweets Ago"],fox_tweets["Compound"], 
            s=50, c="yellow", 
            edgecolor="black", linewidths=1, marker="o", 
            alpha=0.8, label="Fox News")

plt.scatter(nyt_tweets["Tweets Ago"],nyt_tweets["Compound"], 
            s=50, c="green", 
            edgecolor="black", linewidths=1, marker="o", 
            alpha=0.8, label="New York Times")

plt.title("Sentiment Analysis of Media tweets 2017")
plt.ylabel("Tweet Polarity")
plt.xlabel("Tweets Ago")
plt.xlim((0,40))
plt.grid(True) 

lgnd = plt.legend(fontsize="small", mode="Expanded", 
                  numpoints=1, scatterpoints=1, 
                  loc="best", title="Media Sources", 
                  labelspacing=1)
lgnd.legendHandles[0]._sizes = [30]
lgnd.legendHandles[1]._sizes = [30]
lgnd.legendHandles[2]._sizes = [30]



plt.show()
```


![png](output_4_0.png)



```python
bbc_group = sentiments_pd.groupby("source")["Compound"].mean()["BBCWorld"]
cbs_group = sentiments_pd.groupby("source")["Compound"].mean()["CBSNews"]
cnn_group = sentiments_pd.groupby("source")["Compound"].mean()["CNN"]
fox_group = sentiments_pd.groupby("source")["Compound"].mean()["FoxNews"]
nyt_group = sentiments_pd.groupby("source")["Compound"].mean()["nytimes"]

x_labels = ["BBCWorld", "CBSNews", "CNN", "FoxNews", "nytimes"]
y_sentiments = [bbc_group, cbs_group, cnn_group, fox_group, nyt_group]
palette = ['#c6fcff', '#1b919a', '#ff0033', '#000099', '#ffff66']

x_pos = [0,1,2,3,4]
plt.bar(x_pos, y_sentiments, color=sns.color_palette(palette,5), align='center', width = 1, edgecolor = 'bk', linewidth = .6)
plt.xlim(-0.5, len(x_labels)-0.49)
plt.ylim(min(y_sentiments)-0.1, max(y_sentiments)+0.1)
plt.xticks(x_pos, x_labels)
plt.title("Overall Media Sentiment based on Twitter ({})".format(Date), fontsize = 14)
plt.ylabel("Tweet Polarity", fontsize =14)

for a,b in zip(x_pos, y_sentiments):
    if b <= 0:
        B = b-0.035
    else:
        B = b+0.015
    plt.text(a-0.25, B, str(round(b,2)),fontsize = 13)
    
plt.savefig("Overall Media Sentiment based on Twitter.png")

plt.show()



```


![png](output_5_0.png)



```python

```


```python

```


```python

```


```python

```
