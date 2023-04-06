from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
import time
import json

subreddit = "python"
num_posts = 100

options = Options()
options.headless = True
driver = webdriver.Firefox(options=options)

driver.get("https://www.reddit.com/r/" + subreddit)

# Scroll down to load more posts
for i in range(num_posts // 25):
    driver.find_element_by_tag_name("body").send_keys(Keys.END)
    time.sleep(1)

# Get all the post elements
posts = driver.find_elements_by_xpath('//div[@class="_1oQyIsiPHYt6nx7VOmd1sz"]')

# Load existing posts from file
try:
    with open("posts.json", "r") as f:
        existing_posts = json.load(f)
except FileNotFoundError:
    existing_posts = []

# Loop through each post and extract information
new_posts = []
for post in posts:
    post_id = post.get_attribute("id")
    title = post.find_element_by_xpath('.//h3').text
    if title in existing_posts:
        continue
    existing_posts.append(title)
    content = post.text.replace(title, "").strip()
    if not content:
        # Get top 5 comments if content is empty
        comments = post.find_elements_by_xpath('.//div[@class="_3JgI-GOrkmyIeDeyzXdyUD"]')
        if len(comments) > 5:
            comments = comments[:5]
        content = ""
        for comment in comments:
            content += "\n" + comment.text.strip()
    new_posts.append({"id": post_id, "title": title, "content": content})
    # Take screenshot of the post
    driver.execute_script("arguments[0].scrollIntoView();", post)
    time.sleep(1)
    driver.save_screenshot(f"ss/{post_id}.png")

# Save new posts to file
with open("posts.json", "w") as f:
    json.dump(existing_posts, f)

# Close the browser
driver.quit()
