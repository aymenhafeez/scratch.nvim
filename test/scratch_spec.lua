-- just testing out testing with plenary
describe("scratch", function()
  it("can be required", function()
    require("scratch")
  end)

  it("can open scratch float window", function()
    require("scratch").ToggleScratch()
  end)
end)
