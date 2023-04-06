import praw
import json

# Initialize the Reddit instance
reddit = praw.Reddit(client_id='PNiQOPTogO8_29MbAY9KlA',
                     client_secret='bB5xVu6HX01EHY2YBhlC3SWICUfkYA',
                     user_agent='myBot/0.0.1')

# Set the subreddit to retrieve posts from
subreddit = reddit.subreddit('SUBREDDIT_NAME')

# Load previously retrieved post IDs
try:
    with open('posts.json', 'r') as f:
        posts = json.load(f)
except FileNotFoundError:
    posts = []

# Retrieve a post that hasn't been retrieved before
for post in subreddit.top(limit=100):
    if post.id not in posts:
        # Add post ID to the list of retrieved posts
        posts.append(post.id)

        # Extract post title and content
        title = post.title
        content = post.selftext

        # Save post data to a JSON file
        with open('posts.json', 'w') as f:
            json.dump(posts, f)
        with open(f'{post.id}.json', 'w') as f:
            json.dump({'title': title, 'content': content}, f)
        break
else:
    print('All top posts have already been retrieved.')
