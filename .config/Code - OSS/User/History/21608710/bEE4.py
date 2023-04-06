import time
import os
import requests
from selenium import webdriver
from PIL import Image

# Set up Firefox driver
driver = webdriver.Firefox()

# Navigate to subreddit
subreddit = "learnpython"
url = f"https://www.reddit.com/r/AskReddit"
driver.get(url)

# Wait for page to load
time.sleep(5)

# Take screenshots of top 5 posts and their top 5 comments
for i in range(1, 6):
    # Find post title
    post_title = driver.find_element_by_xpath(f"//div[@id='header-bottom-left']/div[2]/div[2]/div[1]/div/div[{i}]/div[2]/div[1]/a").text

    # Find top 5 comments
    comments = []
    for j in range(1, 6):
        try:
            comment = driver.find_element_by_xpath(f"//div[@id='header-bottom-left']/div[2]/div[2]/div[1]/div/div[{i}]/div[2]/div[3]/div[{j}]/div[2]/div/div[1]/div").text
            comments.append(comment)
        except:
            pass

    # Take screenshot of post title and comments
    screenshot_folder = "screenshots"
    if not os.path.exists(screenshot_folder):
        os.makedirs(screenshot_folder)

    screenshot_path = os.path.join(screenshot_folder, f"{subreddit}_post_{i}.png")
    driver.save_screenshot(screenshot_path)

    img = Image.open(screenshot_path)
    title_box = (0, 0, img.width, img.height/2)
    title_img = img.crop(title_box)
    title_img.save(screenshot_path)

    comment_box = (0, img.height/2, img.width, img.height)
    comment_img = img.crop(comment_box)
    comment_img.save(screenshot_path)

    # Print post title and comments
    print(f"Post #{i} - {post_title}")
    print("Top 5 comments:")
    for comment in comments:
        print(comment)
    print("\n")

driver.quit()
