# Bookmarklets

## Template

A template.

```js
javascript:(function() {
  alert("Hello World");
})();
```

## Humble Bundle Downloader

```js
javascript:(function() {
  var url = window.location;
  var title = document.title.split(":")[1].split("(")[0].trim();

  var date = new Date();
  var year = date.getFullYear();
  var month = ('0' + (date.getMonth() + 1)).slice(-2);

  var dir = 'Humble Book Bundle - ' + year + '-' + month + ' - ' + title;

  var links = document.querySelectorAll('a[href*=".epub"], a[href*=".pdf"], a[href*=".mobi"], a[href*=".torrent"], a[href*=".zip"]');
  var linklist = '';
  links.forEach(function(link) {
    linklist += link.href + '\n';
  });

  document.documentElement.innerHTML = `<pre>`
    + `mkdir "${dir}"<br>`
    + `cd "${dir}"<br>`
    + `echo "${url}" > 00_bundle_downloadpage.txt<br>`
    + `cat << EOI > 00_bundle_links.txt<br>`
    + `${linklist}<br>EOI<br>`
    + `<br>`
    + `xargs -P 15 -n 1 curl -JLO < 00_bundle_links.txt<br>`
    + `</pre>`;
})();
```

## Media.ccc.de Information

```js
javascript:
    (function () {
        var title = document.querySelector('.player-header > h1').innerText;
        var subtitle = document.querySelector('.player-header > h2');
        var url = document.URL;
        var speakers = document.querySelector('.persons').innerText.trim();
        var text = '### ' + title + '\n\n';
        if (subtitle != null){
            text += '- Subtitle: ' + subtitle.innerText + '\n';
        }
        text += '- Talk: ' + url + '\n';
        text += '- Speakers: ' + speakers + '\n';
        alert(text);
    }());
```

## BuildWith

Shows the current page non buildwith.com:

```js
javascript:
    (function () {
        window.location = 'https://builtwith.com/' + window.location.hostname;
    }());
```


## File robots.txt

Shows the `robots.txt` for the current website.

```js
javascript:
    (function () {
        window.location = window.origin + "/robots.txt";
    }());
```

## File security.txt

Shows the `security.txt` for the current website.

```js
javascript:
    (function () {
        window.location = window.origin + "/.well-known/security.txt";
    }());
```

## Link Popup

Shows the title and URL in a popup.

```js
javascript:
    (function () {
        alert("Link:\n\n" + document.title + ": " + document.location);
    }());
```

## Toot on infosec.exchange

A template.

```js
javascript:
    (function () {
        window.open('https://infosec.exchange/share?text=' + encodeURIComponent(document.title) + ' ' + encodeURIComponent(window.location.href) + encodeURIComponent(window.getSelection().toString() ? '' : '') + encodeURIComponent(window.getSelection().toString()), '_blank', 'width=600,height=600,toolbar=no');
    }());
```


## Web Archive First

Opens the first archived page on the web archive.


```js
javascript:
    (function () {
        window.location = "https://web.archive.org/web/0/" + window.location;
    }());
```

## Web Archive Latest

Opens the latest archived page on the web archive.

```js
javascript:
    (function () {
        window.location = "https://web.archive.org/web/" + window.location;
    }());
```

## Web Archive Add Site

Adds the current site to the web archive.

```js
javascript:(function() {
    window.location.href = 'https://web.archive.org/save/' + encodeURIComponent(window.location.href);
})();
```

## Google Web Cache

Opens the page in Google Web Cache.

```js
javascript:
    (function () {
        window.location = "https://google.com/search?q=cache:" + window.location;
    }());
```

## Extract all Links to PDFs

```js
javascript:(function() {
  var links = document.querySelectorAll('a[href$=".pdf"]');
  var result = '';
  links.forEach(function(link) {
    result += link.href + '\n';
  });
  console.log(result);
})();
```
