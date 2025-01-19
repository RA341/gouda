# Categories

Categories are the media folder where the media will finally be stored.

It is expected that the folder will be used by [audiobookshelf](https://www.audiobookshelf.org/) or whatever software
you use to server your files.


> For example:
> If you selected the `manga` category,
>
> then gouda will do the following:
> ```
>   /media
>    | /downloads <-- files downloaded by your download client
>    | /audiobooks
>    | /comics
>    | /manga <--- automatically created by gouda if it doesn't exist
>      | /author <--- sub folders are also created
>       | /name
>        | <final file or folder downloaded automatically hardlinked>
> ```
> 



### Configuration

Categories are configured via the webui, on the settings page

:::important

Categories ARE REQUIRED when downloading any media.

If you have not setup any categories, the extension will display an error.
:::