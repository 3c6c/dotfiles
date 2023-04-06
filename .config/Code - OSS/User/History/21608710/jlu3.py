import praw
import json

reddit = praw.Reddit(client_id="PNiQOPTogO8_29MbAY9KlA",
                     client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
                     user_agent='bot a hot')

subreddit_name = 'AskReddit'
num_posts = 10

hot_posts = reddit.subreddit(subreddit_name).hot(limit=num_posts)

posts = []
for post in hot_posts:
    post_dict = {
        'title': post.title,
        'content': post.selftext,
        'score': post.score,
        'num_comments': post.num_comments,
        'permalink': post.permalink
    }
    posts.append(post_dict)

with open('posts.json', 'w') as f:
    json.dump(posts, f, indent=4)


with open('posts.json', 'r') as f:
    posts = json.load(f)

for post in subreddit.top(limit=10):
    if post.id not in posts:
        posts[post.id] = {'title': post.title, 'content': post.selftext}
        print(f'Saving post with ID {post.id} to JSON file.')
        
with open('posts.json', 'w') as f:
    json.dump(posts, f)