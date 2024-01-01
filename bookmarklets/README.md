# Bookmarklets

## Humble Bundle Downloader

```js
javascript:
    (function () {
        var url = window.location;
        var title = document.getElementById('hibtext').textContent.match('Humble .*')[0].split(':')[1].trim();
        var date = new Date();
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var dir = 'Humble Book Bundle - ' + year + '-' + month + ' - ' + title;
        var dl_links = document.querySelectorAll('[href^="https://dl.humble.com"]');
        var dl_list = '';
        for (i = 0; i < dl_links.length; ++i) {
            dl_list += dl_links[i].href + '\n';
        }
        document.documentElement.innerHTML = '<pre>mkdir "' + dir + '"<br>cd "' + dir + '"<br>echo "' + url + '" > bundle_downloadpage.txt<br>cat << EOI > bundle_links.txt<br>' + dl_list + 'EOI<br><br>xargs -n 1 curl -JLO < bundle_links.txt<br>for i in *\\?*; do mv -vf "${i}" "${i%%\\?*}"; done</pre>';
    }());
```

## Media.ccc.de Information

```js
javascript:
    (function () {
        var title = document.querySelector('.player-header > h1').innerText;
        var subtitle = document.querySelector('.player-header > h2').innerText;
        var url = document.URL;
        var speakers = document.querySelector('.persons').innerText.trim();
        var text = '### ' + title + '\n\n';
        text += '- Subtitle: ' + subtitle + '\n';
        text += '- Talk: ' + url + '\n';
        text += '- Speakers: ' + speakers + '\n';
        alert(text);
    }());
```
