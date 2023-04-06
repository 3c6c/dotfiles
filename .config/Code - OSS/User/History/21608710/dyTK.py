import praw
import json
from selenium import webdriver

reddit = praw.Reddit(client_id="PNiQOPTogO8_29MbAY9KlA",
                     client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
                     user_agent='bot a hot')

subreddit = reddit.subreddit("AskReddit")

# Read existing posts from file
existing_posts = []
try:
    with open('posts.json', 'r') as f:
        size = len(f.read())
        if size > 0:
            f.seek(0)
            existing_posts = json.load(f)
except FileNotFoundError:
    pass
except json.JSONDecodeError:
    pass


# Add new posts to existing ones and save to file
existing_posts += new_posts
with open('posts.json', 'w') as f:
    json.dump(existing_posts, f, indent=4)


subreddit_name = 'python'
limit = 10

# Load existing posts
try:
    with open('existing_posts.json', 'r') as f:
        existing_posts = json.load(f)
except (json.decoder.JSONDecodeError, FileNotFoundError):
    existing_posts = []

# Get new posts
new_posts = []
for post in reddit.subreddit(subreddit_name).hot(limit=limit):
    if post.id not in existing_posts:
        # Add post to new_posts
        new_posts.append({
            'id': post.id,
            'title': post.title,
            'content': post.selftext,
            'url': post.url
        })
        # Take screenshot of title and content
        driver = webdriver.Chrome()
        driver.get(post.url)
        driver.save_screenshot(f'ss/{post.id}.png')
        driver.quit()

# Merge new and existing posts
all_posts = new_posts + [p for p in existing_posts if p['id'] not in [np['id'] for np in new_posts]]

# Save all posts to file
with open('existing_posts.json', 'w') as f:
    json.dump(all_posts, f, indent=4)

# Print new posts
for post in new_posts:
    print(f"Title: {post['title']}\nContent: {post['content']}\nScreenshot saved as ss/{post['id']}.png\n")