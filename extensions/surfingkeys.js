const { addSearchAlias, map, mapkey, vmap, Front } = api;

// direction arrows
vmap("<ArrowLeft>", "h");
vmap("<ArrowDown>", "j");
vmap("<ArrowUp>", "k");
vmap("<ArrowRight>", "l");

map("<Ctrl-q>", "<Alt-s>"); // toggle Surfing keys
map("e", "d"); // remap scroll down

// set theme
settings.theme = `
.sk_theme {
    background: #2f343f !important;
    color: #b8bdc2;
}
.sk_theme tbody {
    background: #2f343f !important;
    color: #b8bdc2;
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: #2173c5;
}
.sk_theme .annotation {
    color: #38f;
}
.sk_theme .omnibar_highlight {
    color: #fbd60a;
}
.sk_theme ul>li:nth-child(odd) {
    background: #1e211d;
}
.sk_theme ul>li.focused {
    background: #4ec10d;
}`;

// Search engines
const searchEngines = [
  {
    key: "g",
    name: "Google",
    url: "https://google.com/search?q=",
    fn: null,
  },
  {
    key: "m",
    name: "Hackage",
    url: "https://www.haskell.org/hoogle/?hoogle=",
    fn: null,
  },
  {
    key: "h",
    name: "Home Manager",
    url: "https://home-manager-options.extranix.com/?query=",
    fn: null,
  },
  {
    key: "n",
    name: "Nix",
    url: "https://search.nixos.org/packages?channel=unstable&query=",
    fn: null,
  },
  {
    key: "p",
    name: "Pursuit",
    url: "https://pursuit.purescript.org/search?q=",
    fn: null,
  },
  {
    key: "l",
    name: "Libgen",
    url: "https://libgen.is/search.php?req=",
    fn: null,
  },
  {
    key: "d",
    name: "DDG",
    url: "https://duckduckgo.com/?q=",
    fn: null,
  },
  {
    key: "y",
    name: "youtube",
    url: "https://www.youtube.com/results?search_query=",
    fn: function (response) {
      var res = JSON.parse(response.text);
      return res[1];
    },
  },
  {
    key: "w",
    name: "Wikipedia",
    url: "https://en.wikipedia.org/wiki/",
    fn: null,
  },
  {
    key: "r",
    name: "docs.rs",
    url: "https://doc.rust-lang.org/stable/std/?search=",
    fn: null,
  },
  {
    key: "t",
    name: "Google Translate",
    url: "https://translate.google.com/?hl=en&tab=TT#view=home&op=translate&sl=auto&tl=en&text=",
    fn: null,
  },
];

searchEngines.forEach((x) => {
  addSearchAlias(x.key, x.name, x.url, "s", x.fn);

  mapkey(`o${x.key}`, `Search with ${x.name}`, function () {
    Front.openOmnibar({ type: "SearchEngine", extra: x.key });
  });
});

// youtube full screen
mapkey(`F`, `Toglle fullscreen`, function () {
  document.querySelector(".fullscreen-icon").click();
});
