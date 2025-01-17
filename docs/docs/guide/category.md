# Categories

Categories are the media folder where the final books will be stored.

For example:

Gouda uses category sent when downloading the media, for example, if you used `manga` category,

then gouda will do the following:
```
/media
| /downloads
| /audiobooks
| /comics
| /manga <--- automatically created by gouda if it doesn't exist
 | /author <--- sub folders are also created 
  | /name
   | <final file or folder downloaded automatically hardlinked>
```

### Configuration
Categories are configured via the webui, on the settings page 

:::important

Categories ARE REQUIRED when downloading any media. 

If you not setup categories, the extension will display an error.
:::