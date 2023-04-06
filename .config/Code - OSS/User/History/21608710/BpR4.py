import praw
import json

reddit = praw.Reddit(client_id="PNiQOPTogO8_29MbAY9KlA",
                     client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
                     user_agent='bot a hot')

subreddit = reddit.subreddit("AskReddit")
hot_posts = subreddit.hot(limit=10)

fetched_posts = []

for post in hot_posts:
    if post.stickied or post.over_18:
        continue
    content = post.selftext.strip()
    if not content:
        post.comments.replace_more(limit=0)
        comments = post.comments[:5]
        content = ""
        for comment in comments:
            content += f"{comment.body.strip()}\n"
    fetched_posts.append({
        "title": post.title,
        "content": content
    })

# Load existing posts from file if it exists
try:
    with open('fetched_posts.json', 'r') as f:
        existing_posts = json.load(f)
except FileNotFoundError:
    existing_posts = []

# Filter out already fetched posts
new_posts = []
for post in fetched_posts:
    if post not in existing_posts:
        new_posts.append(post,'\n')

# Append new posts to existing posts and write to file
all_posts = existing_posts + new_posts
with open('fetched_posts.json', 'w') as f:
    json.dump(all_posts, f)