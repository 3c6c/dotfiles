import praw
import os
from gtts import gTTS
from moviepy.editor import *

# Authenticate with Reddit API
reddit = praw.Reddit(client_id='YOUR_CLIENT_ID', 
                     client_secret='YOUR_CLIENT_SECRET', 
                     user_agent='YOUR_USER_AGENT')

# Set up output directory and other configuration options
outputDir = "output"
if not os.path.exists(outputDir):
    os.makedirs(outputDir)
voiceRate = 0.7
voiceLang = "en-us"

# Get top posts from subreddit
subreddit = reddit.subreddit("YOUR_SUBREDDIT_NAME")
topPosts = subreddit.top(limit=10)

# Iterate through each post and generate robot voice audio
for post in topPosts:
    print("Processing post: ", post.title)
    postTitle = post.title
    postContent = post.selftext
    if len(postContent) == 0:
        postContent = "No description available"
    postText = postTitle + " " + postContent
    audioFilename = outputDir + "/" + post.id + ".mp3"
    tts = gTTS(text=postText, lang=voiceLang, slow=False)
    tts.speed = voiceRate
    tts.save(audioFilename)

    # Create video clip with robot voice audio
    videoFilename = outputDir + "/" + post.id + ".mp4"
    audioClip = AudioFileClip(audioFilename)
    audioDuration = audioClip.duration
    w, h = 1920, 1080
    fps = 24
    backgroundColor = (255, 255, 255)
    videoClip = ColorClip((w, h), backgroundColor, duration=audioDuration)
    videoClip = videoClip.set_audio(audioClip)
    videoClip = videoClip.set_fps(fps)
    videoClip.write_videofile(videoFilename, fps=fps, audio_fps=44100, codec='libx264')
    
print("Processing complete!")
