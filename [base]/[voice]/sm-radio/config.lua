Config = {}

Config.jobChannels = {
    -- Set custom channels for jobs here
    -- job: Name of the job
    -- min & max: Minimum and maximum restricted channel the job can join
    {job="police", min=900, max=1000},
    {job="ambulance", min=700, max=900}
}

-- Set the default key to open the radio.
Config.DefaultOpenKey = "m"