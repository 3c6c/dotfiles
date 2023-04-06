import praw
import json

reddit = praw.Reddit(client_id="PNiQOPTogO8_29MbAY9KlA",
                     client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
                     user_agent='bot a hot')

subreddit = reddit.subreddit("AskReddit")
# Load existing posts from file
with open('posts.json', 'r') as f:
    existing_posts = json.load(f)

new_posts = []
for post in subreddit.top('week', limit=10):
    if post.id not in existing_posts:
        new_post = {}
        new_post['id'] = post.id
        new_post['title'] = post.title
        new_post['content'] = post.selftext
        if new_post['content'] == '':
            new_post['comments'] = []
            for comment in post.comments[:5]:
                new_post['comments'].append(comment.body)
        new_posts.append(new_post)

# Save new posts to file
with open('posts.json', 'a') as f:
    for post in new_posts:
        json.dump(post, f)
        f.write('\n')
    
# Update existing posts with new ones
existing_posts += [post['id'] for post in new_posts]
with open('posts.json', 'w') as f:
    json.dump(existing_posts, f)