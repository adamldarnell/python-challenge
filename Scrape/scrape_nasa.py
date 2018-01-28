from bs4 import BeautifulSoup
import requests
 
def scrape():
    listings = {}

    url = "https://mars.nasa.gov/news/"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    listings["title"] = soup.find("a", class_="content_title").get_text()
    listings["body"] = soup.find("span", class_="article_teaser_body").get_text()
    listings["hood"] = soup.find("span", class_="result-hood").get_text()

    return listings