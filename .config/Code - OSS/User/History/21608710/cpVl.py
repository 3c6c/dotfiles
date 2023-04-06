import json
import os
import time

from selenium import webdriver
from selenium.webdriver.firefox.options import Options

options = Options()
options.headless = True

# Replace 'reddit.com' with the subreddit you want to scrape
url = 'https://reddit.com/r/python'

driver = webdriver.Firefox(options=options)

# Navigate to the subreddit
driver.get(url)

# Wait for the page to load
time.sleep(5)

# Get the title of the first post
post_title = driver.find_element_by_xpath('//h3').text

# Get the top 5 comments of the first post
comments = driver.find_elements_by_xpath('//div[@class="_1rZYMD_4xY3gRcSS3p8ODO"]')[:5]
comments_text = [comment.text for comment in comments]

# Take a screenshot of the post and save it to a 'ss' folder
if not os.path.exists('ss'):
    os.mkdir('ss')
driver.save_screenshot('ss/post.png')

# Save the post title and comments to a JSON file in a 'content' folder
if not os.path.exists('content'):
    os.mkdir('content')
data = {
    'title': post_title,
    'comments': comments_text
}
with open('content/post.json', 'w') as f:
    json.dump(data, f)

# Close the browser
driver.quit()
