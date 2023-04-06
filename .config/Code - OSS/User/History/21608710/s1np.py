import praw
import json

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

# Get new top posts
new_posts = []
for post in subreddit.top(limit=10):
    if post.id not in [p['id'] for p in existing_posts]:
        if not post.selftext:
            # If post content is empty, get top 5 comments
            comments = []
            for comment in post.comments[:5]:
                comments.append(comment.body)
            new_posts.append({'id': post.id, 'title': post.title, 'content': '\n'.join(comments)})
        else:
            new_posts.append({'id': post.id, 'title': post.title, 'content': post.selftext})

# Add new posts to existing ones and save to file
existing_posts += new_posts
with open('posts.json', 'w') as f:
    json.dump(existing_posts, f, indent=4)