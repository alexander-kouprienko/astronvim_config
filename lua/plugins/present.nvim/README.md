# `present.nvim`

Hey, this is a plugin for presenting markdown files!!

# Features: Neovim Lua Execution

Can execute code in lua blocks, when you have them in a slide

```lua
print("Hello world", 37, true)
```

# Features: Neovim Lua Execution

Can execute code in lua blocks, when you have them in a slide

```javascript
console.log({myfield: true, otherfield: false});
```

# Features: Other Langs

Can execute code in Language blocks, when you have them in a slide.

You may need to configure this with `opts.executors`, only have Lua, Python, Javascript, and Rust by default.

```python
print("yaayayayaya python")
```

# Usage

```lua
require("present").start_presentation {}
```

Use `n`, and `p` to navigate markdow slides.

Or use `:PresentStart` Command

# Credits

Kuper4ek
