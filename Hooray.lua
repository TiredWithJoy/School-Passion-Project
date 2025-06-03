local ui = require "ui"
--Calendar.selected
-- create a simple Window 
local win = ui.Window("Work Tracker", 1920, 1080)

local tab = ui.Tab(win, {"Calendar", "Statistics", "Stats Setter"}, 0, 0, 1920, 1080)

local date = {}
for i = 1, 12 do
    date[i] = {}
    for j = 1, 31 do
        date[i][j] = 0 -- Fill the values here
    end
end

local calendar = ui.Calendar(tab.items[1], 0, 0, 1920, 1080)

local bar = {ui.Progressbar(tab.items[2], 0, 914, 1080, 90), ui.Progressbar(tab.items[2], 0, 794, 1080, 90), ui.Progressbar(tab.items[2], 0, 674, 1080, 90), ui.Progressbar(tab.items[2], 0, 554, 1080, 90), ui.Progressbar(tab.items[2], 0, 434, 1080, 90), ui.Progressbar(tab.items[2], 0, 314, 1080, 90), ui.Progressbar(tab.items[2], 0, 194, 1080, 90)}
local statLabel = ui.Label(tab.items[2], "How many hours you worked out of 24 shown visualy (Sorted oldest to newest, based off of your selected date)", 0, 100)


local inputLabel = ui.Label(tab.items[3], "Insert the number of hours you worked on the selected date. (Make sure you have a date selected on the calendar)", 0, 0)
inputLabel:center()
inputLabel.y =  300
local dataInsert = ui.Entry(tab.items[3], "", 0, 0, 200, 100)
dataInsert:center()
dataInsert.y = 600


function dataInsert:onSelect()
  if tostring(tonumber(dataInsert.text)) == dataInsert.text then
    if not(tonumber(dataInsert.text) > 24) or  not (tonumber(dataInsert.text) < 0) then
      date[calendar.selected.month][calendar.selected.day] = tonumber(dataInsert.text)
      for p, u in ipairs(bar) do
        x = calendar.selected.day - (p - 1)
        z = calendar.selected.month
        bar[p].range = { 0, 24 }
        if x < 1 then
          z = z - 1
          x = x + 31
        end
        bar[p].position =  date[z][x]
      end
    end
  else
    ui.msg("You have to enter a number no other characters")
  end
end


win:show()
-- update user interface
repeat
	ui.update()
until not win.visible