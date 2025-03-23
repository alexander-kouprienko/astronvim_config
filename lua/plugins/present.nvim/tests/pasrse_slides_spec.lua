-- vim.g.testing = true
-- local assert = require "luassert"
-- local plenary = require "plenary"

local eq = assert.are_same
local parse = require("present")._parse_slides
describe("present.parse_slides", function()
  it(
    "should parse an empty file",
    function()
      eq({
        slides = {
          {
            title = "",
            body = {},
            blocks = {},
          },
        },
      }, parse {})
    end
  )

  it(
    "should parse a file with one slide",
    function()
      eq(
        {
          slides = {
            {
              title = "# This is the first slide",
              body = { "this is the body" },
              blocks = {},
            },
          },
        },
        parse {
          "# This is the first slide",
          "this is the body",
        }
      )
    end
  )

  it("should parse a file with one slide and a block", function()
    local results = parse {
      "# This is the first slide",
      "this is the body",
      "```lua",
      'print("hi")',
      "```",
    }

    -- Should have only one slide
    eq(1, #results.slides)

    local slide = results.slides[1]
    eq(slide.title, "# This is the first slide")

    eq({
      "this is the body",
      "```lua",
      'print("hi")',
      "```",
    }, slide.body)

    local block = {
      language = "lua",
      body = 'print("hi")',
    }

    eq(block, slide.blocks[1])
  end)
end)
