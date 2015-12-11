# boss-v2

A new and improved chat bot.

## Commands:

- `boss gif me QUERY` --> will return a GIF from Giphy that it searches for with your query
- `boss pic me QUERY` --> will return a photo/GIF from Cloudinary and
  Redis that matches your query keyword.
- `boss pic add KEYWORD: URL` --> will store the photo with URL in
  Cloudinary and Redis, under the KEYWORD provided, for later use.
- `boss ping` --> will return pong
- `boss swanson me` --> will return a Ron Swanson GIF from Giphy
