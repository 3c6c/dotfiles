import json
import os
import time
from selenium import webdriver

# Set up the webdriver
options = webdriver.ChromeOptions()
options.add_argument('headless') # Run Chrome in headless mode
driver = webdriver.Chrome(options=options)

# Set up the subreddit and post URL
subreddit = "learnpython"
post_url = "https://www.reddit.com/r/" + subreddit + "/comments/nuclw3"

# Navigate to the post URL
driver.get(post_url)
time.sleep(2) # Wait for the page to load

# Get the title of the post
post_title = driver.find_element_by_class_name("rpBJOHq2PR60pnwJlUyP0").text

# Get the top 5 comments from the post
comment_elements = driver.find_elements_by_xpath("//div[@class='_1E9mcoVn4MYnuBQSVDt1gC']")
comment_texts = [elem.text for elem in comment_elements[:5]]

# Take a screenshot of the post and save it to the 'ss' folder
if not os.path.exists("ss"):
    os.makedirs("ss")
driver.save_screenshot("ss/" + subreddit + ".png")

# Save the post title and comments to the 'content' folder as a JSON file
if not os.path.exists("content"):
    os.makedirs("content")
data = {"title": post_title, "comments": comment_texts}
with open("content/" + subreddit + ".json", "w") as f:
    json.dump(data, f)
