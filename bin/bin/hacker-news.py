import requests
import concurrent.futures


def get_story(story_id):
    # 各ストーリーの詳細を取得するためのURL
    story_url = (
        f"https://hacker-news.firebaseio.com/v0/item/{story_id}.json?print=pretty"
    )

    # ストーリーの詳細を取得
    story_response = requests.get(story_url)
    story_data = story_response.json()

    if story_data["score"] >= 500:
        # タイトルを表示
        try:
            print(f'[{story_data["score"]}]  ', story_data["title"])
        except Exception as e:
            print("something went wrong...")


def get_topstories(n=500):
    # Hacker Newsの"top stories" APIエンドポイント
    top_stories_url = (
        "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    )

    # top storiesのIDを取得
    response = requests.get(top_stories_url)
    top_stories_ids = response.json()

    with concurrent.futures.ThreadPoolExecutor() as executor:
        for story_id in top_stories_ids[:n]:
            executor.submit(get_story, story_id)


# スクリプトを実行
get_topstories()
