# Overview

`panfig` is a script that facilitates using [pandoc](https://pandoc.org) to
render documents such as markdown. Pandoc formats can be customized via its
command line to do things like produce academic bibliographies with citations
via [citeproc][citeproc], change page margins, and highlight links to be
specified colors. However, the list of arguments can become somewhat long.
`panfig` allows frequently used pandoc calls to be saved into configuration
blocks so that they can be easily invoked. The goal is to make it as easy as
possible to render and view documents as they are being authored and to be
usable in a minimal environment with only pandoc, a text editor, and a tool to
view the rendered document.

By default, `panfig` renders the document source and exits. A configured
previewer can also be launched, which will remain open after `panfig`
completes. There is also a "watch" mode that periodically monitors the document
source and rerenders it when the modification time changes on the file.

# Limitations

This program has been designed to work with documents that consist of a single
file.

# Installation

Clone the repo. Run `make` to copy the script to `~/.local/bin` and the default
config file to `~/.config`

```bash
$ git clone https://github.com/andrewraim/panfig
$ make
```

To invoke the scripts as commands, add `~/.local/bin` to your `$PATH` as
follows. Include it in your bash configuration file to make it persist in
subsequent terminal sessions.

```bash
$ export PATH=$HOME/.local/bin:$PATH
```

This should make the script accessible as commands.

```bash
$ panfig -f slides examples/slides.md
```

Run the command with `-h` for further information.

# Configuration

The `panfig` configuration is expected to be at path `~/.config/panfig.conf`
and have a format like the following.

```
# This is a comment.

[main]
flags = --citeproc
	--metadata link-citations=true
default = html
peek = 1
rest = 5

[html]
desc = Standalone HTML document
ext = html
flags = -s -t html
view = chromium %s
```

There is one `[main]` block with overall settings and one or more additional
blocks which produce specific pandoc document types ("entries").

The `[main]` block contains the following items.

- `flags`: these flags will be passed to pandoc. Lines starting with an
  indentation are assumed to be continuations of the previous line.
- `default`: the default entry to use, if not specified on the command line.
- `peek`: in watch mode, the number of seconds to wait before checking the
  source file for modifications.
- `rest`: in watch mode, the number of seconds to wait after rerendering the
  document. This is to prevent rerendering from happening too frequently.

The `[html]` block is an example of an entry type. These contain the following
items.

- `desc`: a brief description of the entry. This is shown in the `panfig` help
  message.
- `ext`: the extension to use for output files, unless a specific path is
  given for the output on the command line.
- `flags`: these flags will be passed to pandoc. Lines starting with an
  indentation are assumed to be continuations of the previous line.
- `view`: command to view the rendered output. The string `%s` is a placeholder
  that will be replaced by the program.

# Included Configuration

There are several document formats in the included configuration file which are
somewhat specific to my preferences. Feel free to take them as a starting point
and customize for your own use.

- `pdf`:  PDF document.
- `slides`: PDF slides
- `html`: standalone HTML document.

# Custom Slide Theme

Here is a note on how to use a nonstandard Beamer theme with the included
`slides` entry. Let's use [beamerthemeraim][beamerthemeraim] with
`examples/slides.md` as an example.

Download `beamerthemeraim.sty` to the folder with `slides.md`.

Add the following to the YAML portion of `slides.md`.

```markdown
theme: raim
```

The slides should now render with the custom theme by invoking `panfig` /
`pandoc`.

```bash
$ panfig -f slides examples/slides.md
```

# Auto Refresh in HTML

Some preview tools such as [Zathura][zathura] automatically refresh when the
underlying document has changed. This helps to preview a document as we are
working on it. Web browsers typically do not this without extensions, but we
can request the document be automatically refreshed by adding the following
metadata.

```html
<meta http-equiv="refresh" content="1">
```

The value `1` here instructs the browser to reload every one second. Inserting
this metadata can be accomplished using the `header-includes` argument to
pandoc, as shown in the the included configuration file.

# Also See

- [Glow](https://github.com/charmbracelet/glow): A terminal-based markdown
  reader that does not require a graphical environment.
- [Quarto](https://quarto.org): A markdown-based documentation system that can
  render dynamic documents with embedded R, Python, and Julia code.


[beamerthemeraim]: https://github.com/andrewraim/beamerthemeraim
[citeproc]: https://pandoc.org/demo/example33/9-citations.html
[zathura]: https://pwmt.org/projects/zathura

