# Bookmarklets

## Media.ccc.de Information

[media.ccc.de Information](
javascript:(function(){
var title = document.querySelector(".player-header > h1").innerText;
var subtitle = document.querySelector(".player-header > h2").innerText;
var url = document.URL;
var speakers = document.querySelector(".persons").innerText.trim();

var text = "### " + title + "\n\n";
text += "- Subtitle: " + subtitle + "\n";
text += "- Talk: " + url + "\n";
text += "- Speakers: " + speakers + "\n";

alert(text);
})();
)
