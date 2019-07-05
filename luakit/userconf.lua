local settings  = require "settings"
local downloads = require "downloads"
local select    = require "select"
local follow    = require "follow"
local editor    = require "editor"
local modes     = require "modes"
local rofisel   = require "rofiselect"

--globals.domain_props.all = {
	--zoom_level = 1.5
--}

require "adblock"
require "adblock_chrome"

editor.editor_cmd = "alacritty -e vim {file} +{line}"
downloads.default_dir = os.getenv("HOME") .. "/downloads"

-- {{{ search engines
local engines = settings.window.search_engines
engines.ddg = "https://duckduckgo.com/?q=%s"
engines.aur = "https://aur.archlinux.org/packages.php?O=0&K=%s&do_Search=Go"
engines.aw  = "https://wiki.archlinux.org/index.php/Special:Search?fulltext=Search&search=%s"

engines.default = engines.ddg
-- }}}

select.label_maker = function ()
	return trim(sort(reverse(charset("abcdefghijklmnopqrstuvwxyz"))))
end


modes.add_binds("normal", {
	{"<C-b>", "newtab bookmarks", function(w) rofisel.bookmarks(w, true) end},
	{"b",     "open bookmark",    function(w) rofisel.bookmarks(w, false) end},
	{"<C-t>", "search in tabs",   rofisel.tabs},
	{"<Tab>", "Go forward in history", function(w, m) w:forward(m.count) end},
})

follow.pattern_maker = follow.pattern_styles.match_label

follow.stylesheet = [==[
#luakit_select_overlay {
    position: absolute;
    left: 0;
    top: 0;
    z-index: 2147483647; /* Maximum allowable on WebKit */
}

#luakit_select_overlay .hint_overlay {
    display: block;
    position: absolute;
    background-color: #ffff99;
    border: 1px dotted #000;
    opacity: 0.3;
}

#luakit_select_overlay .hint_label {
    display: block;
    position: absolute;
    background-color: #000088;
    border: 1px dashed #000;
    color: #fff;
    font-size: 16px;
    font-family: monospace, courier, sans-serif;
    opacity: 0.8;
	text-transform: uppercase;
}

#luakit_select_overlay .hint_selected {
    background-color: #00ff00 !important;
}
]==]
