describe("scratch", function()
  it("can be required", function()
    require("scratch")
  end)

  it("can open scratch float window", function()
    require("scratch").ToggleScratch()
  end)

  it("can save scratch window text", function()
    require("scratch").SaveScratch()
  end)
end)
