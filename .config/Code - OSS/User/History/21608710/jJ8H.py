import praw
import json

# create reddit instance
reddit = praw.Reddit(
    client_id="PNiQOPTogO8_29MbAY9KlA",
    client_secret="bB5xVu6HX01EHY2YBhlC3SWICUfkYA",
    user_agent="a simple hot",

)

# specify subreddit to retrieve posts from
subreddit = "AskReddit"

# specify path to json file to save retrieved posts
json_file_path = "posts.json"

# load existing posts from json file
try:
    with open(json_file_path, "r") as f:
        posts = json.load(f)
except FileNotFoundError:
    posts = []

# get latest top post
for post in reddit.subreddit(subreddit).top(limit=10):
    post_data = {
        "title": post.title,
        "content": post.selftext,
    }
    # check if post is already in list of retrieved posts
    if post_data not in posts:
        # add post to list
        posts.append(post_data)

# save updated list of posts to json file
with open(json_file_path, "w") as f:
    json.dump(posts, f, indent=4)

# print latest post
print(posts[-1])

