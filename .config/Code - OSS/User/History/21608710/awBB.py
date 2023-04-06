import praw
import json

reddit = praw.Reddit(client_id="PNiQOPTogO8_29MbAY9KlA",
                     client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
                     user_agent='bot a hot')

subreddit = 'AskReddit'
num_posts = 100

hot_posts = reddit.subreddit(subreddit_name).hot(limit=num_posts)

posts = []
for post in subreddit.hot(limit=10):
    if post.selftext == "":
        post_comments = []
        for comment in post.comments[:5]:
            post_comments.append(comment.body)
        post_dict = {"title": post.title, "content": post.selftext, "comments": post_comments}
        if post_dict not in posts:
            posts.append(post_dict)
    else:
        post_dict = {"title": post.title, "content": post.selftext}
        if post_dict not in posts:
            posts.append(post_dict)

with open('posts.json', 'w') as f:
    json.dump(posts, f, indent=4)