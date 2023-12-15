local _tempYear = os.date("%Y")

local function IsLeapYear(year)
    return (year % 400 == 0) or ((year % 4 == 0) and (year % 100 ~= 0))
end

local DaysInMonth = {
    [1] = 31,
    [2] = IsLeapYear(_tempYear) and 29 or 28,
    [3] = 31,
    [4] = 30,
    [5] = 31,
    [6] = 30,
    [7] = 31,
    [8] = 31,
    [9] = 30,
    [10] = 31,
    [11] = 30,
    [12] = 31
}

-- populated by "Mon", "Tue" etc.
local DayTable = {}

function Initialize()
	FirstWeekdayMeasure = SKIN:GetMeasure('WeekdayOfFirstDayOfMonth')
	CurrentMounth = SKIN:GetMeasure('CurrentMounth')
end

function Update()
	for i=0,6 do
		table.insert(DayTable, i, SKIN:GetMeasure("DN"..i):GetStringValue())
	end
	
	FirstWeekday = FirstWeekdayMeasure:GetValue()

	local DatesList = {}
	
	-- don't you love zero indexing and then having to deal with one-indexed data?
	for i=1,DaysInMonth[CurrentMounth:GetValue()] do
		_tempWeekday = math.fmod(FirstWeekday-1+i, 7)
		
		table.insert(DatesList, i.." "..DayTable[_tempWeekday])
	end
	
	SKIN:Bang("!SetOption", "TheDays", "Text", table.concat(DatesList, "\n"))
	SKIN:Bang("!UpdateMeter", "TheDays")
	SKIN:Bang("!Redraw")
	
end