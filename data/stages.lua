-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 50,
		multiplier = 65
	}, {
		minlevel = 51,
		maxlevel = 100,
		multiplier = 35
	}, {
		minlevel = 101,
		maxlevel = 250,
		multiplier = 15
	}, {
		minlevel = 251,
		maxlevel = 350,
		multiplier = 8
	}, {
		minlevel = 351,
		maxlevel = 550,
		multiplier = 5
    }, {
		minlevel = 551,
		maxlevel = 600,
		multiplier = 3
	}, {
		minlevel = 601,
		maxlevel = 700,
		multiplier = 1.5
	}, {
		minlevel = 701,
		multiplier = 1
	}
}

skillsStages = {
	{
		minlevel = 0,
		maxlevel = 75,
		multiplier = 25
	}, {
		minlevel = 75,
		maxlevel = 100,
		multiplier = 10
	}, {
		minlevel = 101,
		maxlevel = 130,
		multiplier = 5
	}, {
		minlevel = 131,
		multiplier = 3
	}
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 100,
		multiplier = 5
	}, {
		minlevel = 101,
		maxlevel = 130,
		multiplier = 3
	}, {
		minlevel = 131,
		multiplier = 1
	}
}

