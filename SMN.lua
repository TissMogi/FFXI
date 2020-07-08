-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow

--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    -- Include Organizer addon.
    include('organizer-lib')      
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy',
        'Conflag Strike','Crag Throw'}


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl', ['Siren']='Katabatic Blades'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor',['Shiva']='Crystal Blessing', ['Leviathan']='Soothing Current',['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II', ['Siren']='Chinook', ['Siren']="Wind's Blessing"}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye', ['Siren']='Bitter Elegy', ['Siren']='Lunatic Voice'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV', ['Siren']='Tonrado 2'} --might need to change this for Siren
	pacts.bp65 = {['Siren']='Sonic Buffet'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.bp99 = {['Ifrit']='Conflag Strike', ['Shiva']='Rush', ['Garuda']='Wind Blade', ['Titan']='Crag Throw',
        ['Ramuh']='Volt Strike', ['Carbuncle']='Holy Mist', ['Fenrir']='Impact', ['Diabolos']='Blindside', ['Siren']='Hysteric Assault'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor", ['Siren']='Clarsach Call'}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
end

-------------------------------------------------------------------------------------------------------------------
-- User setup variables for this job
-------------------------------------------------------------------------------------------------------------------

send_command('bind ^a gs equip sets.idle')

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.perp_staff = {name=""}

    ---------------------------------------------------------------------------
    -- Augmented Gear Section -------------------------------------------------
    ---------------------------------------------------------------------------
    
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 10;input /item "Warp Ring" <me>')
	-- Locks Weapon and Sub via keybind
    state.WeaponLock = M(false, 'Weapon Lock')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind @t input /item "Mirror\'s Tonic" <me>')
    send_command('bind @y input /item "Savior\'s Tonic" <me>')

    MerlinicHoodBurst = { name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+11%','Mag. Acc.+8',}}
    MerlinicShalwarBurst = { name="Merlinic Shalwar", augments={'Mag. Acc.+6','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
    MerlinicCrackowsBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','MND+1','Mag. Acc.+6','"Mag.Atk.Bns."+1',}}
    
    MerlinicHoodDrain = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +10','DEX+3',}}
    MerlinicJubbahDrain = { name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Drain" and "Aspir" potency +7','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+2',}}
    MerlinicDastanasDrain = { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+30','"Drain" and "Aspir" potency +10','VIT+9',}}
    MerlinicCrackowsDrain = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +8','CHR+2','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}

    MerlinicShalwarDD = { name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Occult Acumen"+7','Mag. Acc.+10','"Mag.Atk.Bns."+11',}}
    MerlinicShalwarDD2 = { name="Merlinic Shalwar", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+4','INT+12','"Mag.Atk.Bns."+15',}}
    
    MerlinicBPPhysical = { name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+30','Blood Pact Dmg.+10','Pet: DEX+8',}}
    MerlinicBPMagical = { name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+18','Blood Pact Dmg.+9','Pet: DEX+10','Pet: Mag. Acc.+12',}}
    
    MerlinicDastanasFC = { name="Merlinic Dastanas", augments={'Mag. Acc.+8','"Fast Cast"+5','CHR+7','"Mag.Atk.Bns."+8',}}
    CCapePhysical = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}}
    CCapeMagical = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}


    ---------------------------------------------------------------------------
    -- Select the default Macro book and page based on subjob -----------------
    ---------------------------------------------------------------------------    
    select_default_macro_book()
    set_lockstyle()
end

-- Organizer Gear to keep in inv for specific job.
organizer_items = {
    echos="Echo Drops",
    remedy="Remedy",
    holy="Holy Water",
    food="Grape Daifuku",
    orb="Macrocosmic Orb",
    cudg1="Nibiru Cudgel"
    }

-- Define sets and vars used by this job file.
function init_gear_sets()

    ---------------------------------------------------------------------------
    -- Precast Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Bloodpac Ability Delay ( Cap:  I - 15s, II - 15s, III - 15s ) ----------
    ---------------------------------------------------------------------------
    sets.precast.BloodPactWard = {
        main="Espiritus",               --00s/02s
        ammo="Sancus Sachet +1",        --00s/07s
        head="Beckoner's Horn +1",
        right_ear="Evans Earring",           --02s
        body="Glyphic Doublet +1",      --00s/02s
        hands="Glyphic Bracers +1",     --06s
        back="Conveyance Cape",         --00s/03s
        feet="Glyphic Pigaches +1"      --00s/01s
    ------------------------------ Total: 16s/15s------------------------------
    }

    sets.precast.BloodPactRage = {
        main="Espiritus",               --00s/02s
        ammo="Sancus Sachet +1",        --00s/07s
        head="Beckoner's Horn +1",
        right_ear="Evans Earring",           --02s
        body="Glyphic Doublet +1",      --00s/02s
        hands="Glyphic Bracers +1",     --06s
        back="Conveyance Cape",         --00s/03s
        feet="Glyphic Pigaches +1"      --00s/01s
    ------------------------------ Total: 16s/15s------------------------------
    }
    --sets.precast = sets.precast.BloodPactRage
    ---------------------------------------------------------------------------
    -- Fast Cast Sets for all Spells ( Cap:80% - SCH:70% - RDM:65% ) ----------
    ---------------------------------------------------------------------------
    sets.precast.FC = {
        main="Oranyan",                 -- 20%
        ammo="Sapience Orb",            -- 02%
        head="Vanya Hood",              -- 10%
        neck="Voltsurge Torque",        -- 04%
        left_ear="Etiolation Earring",  -- 01%
        right_ear="Loquacious Earring", -- 02%  
        body="Inyanga Jubbah +2",       -- 13%
        hands=MerlinicDastanasFC,       -- 05%
        left_ring="Rahab Ring",         -- 02%
        right_ring="Kishar Ring",       -- 04%
        back=CCapeMagical,              -- 10%
        waist="Witful Belt",            -- 03%/03% quick magic
        --legs="Lengo Pants",           -- 05% put them in storage, already over cap
        feet="Regal Pumps +1"           -- 07%
    ------------------------------- Total: 83% --------------------------------
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash"
    })

    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +1"}

    sets.precast.JA['Elemental Siphon'] = {
        main="Espiritus",
        sub="Vox Grip",
        ammo="Esper Stone +1",          -- +20
        head="Telchine Cap",            -- +35
        neck="Caller's Pendant",
        left_ear="Andoaa Earring",
        body="Telchine Chasuble",       -- +35
        hands="Telchine Gloves",        -- +35
        left_ring="Evoker's Ring",
        right_ring="Fervor Ring",
        back="Conveyance Cape",         -- +30mp
		waist="Ligea Sash",				-- +10
        legs="Telchine Braconi",        -- +35
        feet="Beckoner's Pigaches +1"   -- +60
    }
    ------------------------------- Total: 230 / +30mp = 879 mp----------------
            
    sets.precast.JA['Mana Cede'] = {hands="Beckoner's Bracers +1"}
    
    sets.precast.JA['Sublimation'] = {
        head="Inyanga Tiara +2",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",
        hands="Telchine Gloves",
        left_ring="Persis Ring",
        back="Moonbeam Cape",
        waist="Porous Rope",
        legs="Perdition Slops",
        feet="Inyanga Crackows +2"
        }


    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
    sets.midcast.Cursna = set_combine(sets.midcast, {
                             
        --neck="Malison Medallion",
        body="Vanya Robe", 
        left_ring="Haoma's Ring",       -- cursna 15%
        right_ring="Menelaus's Ring",   -- cursna +25
        feet="Vanya Clogs" --Gende. Galosh. +1
    })	
    
    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Telchine Cap",
        --neck="Incanter's Torque",
        left_ear="Andoaa Earring",
        right_ear="Calamitous Earring",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
        waist="Embla Sash",
        legs="Telchine Braconi",
        feet="Telchine Pigaches"
    }
    
    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Inspirited Boots"
        })
    sets.midcast.Storm = sets.midcast['Enhancing Magic']
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic']
    
    sets.midcast.FastRecast = {}
    
    ---------------------------------------------------------------------------
    -- Cure Potency Set ( Healing Magic Skill > MND ) -------------------------
    -- The Cap is 50% for Cure Potency II to take effect ----------------------
    ---------------------------------------------------------------------------
                                            -- Cure Pot.    Mnd     H.M. Skill  Conserve MP 

    sets.midcast.Cure = {
        main="Serenity",                    -- 25%
        sub="Enki Strap",                   --              +10
        ammo="Pemphredo Tathlum",           --                                  +04
        head="Vanya Hood",                  -- 10%                              +06
        neck="Nodens Gorget",               -- 05%
        left_ear="Calamitous Earring",      --                                  +04

        right_ear="Mendicant's Earring",    -- 05%                              +02
        right_ear="Mendicant's Earring",    -- 05%                              +02
        body="Vanya Robe",                  --                      +20
        right_ear="Regal Earring",
        body="Vanya Robe",                  --              +20
        hands="Shrieker's Cuffs",           --                                  +07
        left_ring="Haoma's Ring",           --              +08
        right_ring="Sirona's Ring",         --              +10
        back="Solemnity Cape",              -- 07%          +8                  +05
        waist="Austerity Belt +1", --waist="Luminary Sash",              --              +10                 +04
        legs="Vanya Slops",                 --              +10                 +12
        feet="Vanya Clogs"                  -- 10%                              +06
        }
        --------------------------------Total: 55%                  +38         +50

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        head="Umuthi Hat", 
        neck="Nodens Gorget",
        waist="Siegel Sash"
    })

    sets.midcast['Elemental Magic'] = {}

    sets.midcast['Dark Magic'] = {--[[main="Oranyan",sub="Enki Strap",range="Pemphredo Tathlum",
        head=MerlinicHoodDrain,neck="Erra Pendant",left_ear="Psystorm Earring",right_ear="Lifestorm Earring",
        body="Amalric Doublet",hands=MerlinicDastanasDrain,left_ring="Stikini Ring",right_ring="Stikini Ring",
        back="Bane Cape",waist="Fucho-no-Obi",legs=MerlinicShalwarDD,feet=MerlinicDrain--]]}

    sets.midcast['Aspir'] = {--[[main="Rubicundity",sub="Enki Strap",range="Pemphredo Tathlum",
        head=MerlinicHoodDrain,neck="Erra Pendant",left_ear="Psystorm Earring",right_ear="Lifestorm Earring",
        body="Amalric Doublet",hands=MerlinicDastanasDrain,left_ring="Stikini Ring",right_ring="Stikini Ring",
        back="Bane Cape",waist="Fucho-no-Obi",legs=MerlinicShalwarDD,feet=MerlinicDrain--]]}

-------------------------------------------------------------------------------
------ Generic Bloodpact Sets based on type -----------------------------------
-------------------------------------------------------------------------------
    
    ---------------------------------------------------------------------------
    -- Generic Bloodpact Ward Sets --------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Pet.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Caller's Pendant",left_ear="Andoaa Earring",right_ear="Enmerkar Earring",
        body="Beckoner's Doublet +1",hands="Lamassu Mitts +1",left_ring="Evoker's Ring",right_ring="Stikini Ring +1",
        back="Conveyance Cape",waist="Lucidity Sash",legs="Baayami Slops"}

    sets.midcast.Pet.DebuffBloodPactWard = {main="Nirvana", sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Adad Amulet",left_ear="Lugalbanda Earring",right_ear="Enmerkar Earring",
        body="Beckoner's Doublet +1",hands="Lamassu Mitts +1",left_ring="Evoker's Ring",right_ring="Stikini Ring +1",
        back="Conveyance Cape",waist="Incarnation Sash",legs="Baayami Slops"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    ---------------------------------------------------------------------------
    -- Physical Bloodpact Rage Sets -------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Pet.PhysicalBloodPactRage = {
        main="Nirvana",                 -- 40
        sub="Elan Strap +1",            -- 3
        ammo="Sancus Sachet +1",        -- 15
        head="Apogee Crown +1",         -- 8
        neck="Summoner's Collar +2",
        left_ear="Lugalbanda Earring",  -- 10
        right_ear="Gelos Earring",      -- 5
        body="Convoker's Doublet +3",   -- 16
        hands="Apogee Mitts +1",        -- 8
        left_ring="C. Palug Ring",
        right_ring={ name="Varar Ring +1", bag="wardrobe4"},
        back=CCapePhysical,             -- 5
        waist="Regal Belt",
        legs="Apogee Slacks +1",        -- 21
        feet="Apogee Pumps +1"          -- 10
    }

    ------------------------------- Total: 141 Set Bonus: 10---------------------
        
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
        legs="Apogee Slacks +1"
    })
    ---------------------------------------------------------------------------
    -- Magical Bloodpact Rage Sets --------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Pet.MagicalBloodPactRage = {
        main="Nirvana",                 -- 40
        sub="Elan Strap +1",            -- 3
        ammo="Sancus Sachet +1",        -- 15
        head="Apogee Crown +1",         -- 8
        neck="Summoner's Collar +2",
        left_ear="Lugalbanda Earring",  -- 10
        right_ear="Gelos Earring",      -- 5
        body="Convoker's Doublet +3",   -- 16
        hands="Apogee Mitts +1",        -- 8
        left_ring="C. Palug Ring",
        right_ring={ name="Varar Ring +1", bag="wardrobe4"},
        back=CCapeMagical,              -- 5
        waist="Regal Belt",
        legs="Apogee Slacks +1",        -- 21
        feet="Apogee Pumps +1"          -- 10
    }
        
    ------------------------------- Total: 141 Set Bonus: 10 ---------------------      

    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
        legs="Apogee Slacks +1"
    })

    sets.HP=set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})
----sets.
-------------------------------------------------------------------------------
------ Bloodpact Specific Sets for Rage Pacts ---------------------------------
-------------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- Flaming Crush is a Hybrid Bloodpact 2 Phys + 1 Magical Hit -------------
    ---------------------------------------------------------------------------
    sets.midcast['Flaming Crush'] = sets.midcast.Pet.MagicalBloodPactRage
    
    -- sets.midcast['Flaming Crush'] = set_combine( sets.midcast.Pet.PhysicalBloodPactRage, { 
    --  main="Gridarvor", sub="Elan Strap +1",
    --  head="Apogee Crown +1",
    --  hands="Apogee Mitts",
    --  legs="Beckoner's Spats +1", 
    --  right_ring="Fervor Ring",})
    
    -- sets.midcast['Meteor Strike'] = set_combine( sets.midcast.Pet.MagicalBloodPactRage, { 
    --  right_ring="Fervor Ring",
    --  })
    
    -- sets.midcast['Conflag Strike'] = set_combine( sets.midcast.Pet.MagicalBloodPactRage, { 
    --  right_ring="Fervor Ring",
        -- })
        
    -- sets.midcast['Volt Strike'] = set_combine( sets.midcast.Pet.PhysicalBloodPactRage, { 
    --  main="Was", sub="Elan Strap +1",
    --  head="Apogee Crown +1",
    --  hands="Apogee Mitts",
    --  legs="Apogee Slacks +1"})
	

    ---------------------------------------------------------------------------
    -- Bloodpact Specific Sets for Ward Pacts ---------------------------------
    ---------------------------------------------------------------------------
    -- sets.midcast['Hastega II'] = set_combine( sets.midcast.Pet.BloodPactWard, { 
    --  main="", sub="",ammo="",
    --  head="",neck="",left_ear="",right_ear="",
    --  body="",hands="",left_ring="",right_ring="",
    --  back="",waist="",legs="",feet=""})
	
	

-------------------------------------------------------------------------------
------ Bloodpact Specific Sets for Debuff Ward Pacts --------------------------
-------------------------------------------------------------------------------
    
    ---------------------------------------------------------------------------
    -- Impact attribute reduction is based on Summoning Magic Skill -----------
    -- Soft Cap is 600 Summoning Magic Skill for -32 to all stats -------------
    ---------------------------------------------------------------------------
    -- sets.midcast['Impact'] = set_combine(  DebuffBloodPactWard, { 
    --  main="", sub="",ammo="",
    --  head="",neck="",left_ear="",right_ear="",
    --  body="",hands="",left_ring="",right_ring="",
    --  back="",waist="",legs="",feet=""})


    -- Spirits cast magic spells, which can be identified in standard ways.
    
    -- sets.midcast.Pet.WhiteMagic = {legs="Summoner's Spats"}
    
    -- sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Summoner's Spats"})

    -- sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

-------------------------------------------------------------------------------
------ Idle/resting/defense/etc sets ------------------------------------------
-------------------------------------------------------------------------------
    
    sets.resting = {}
    
    ---------------------------------------------------------------------------
    -- Idle sets --------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.idle = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Hearty Earring",
        body="Shomonjijoe +1",hands="Inyanga Dastanas +2",left_ring="Inyanga Ring",right_ring="Woltaris Ring",
        back=CCapeMagical,waist="Porous Rope",legs="Assiduity Pants +1",feet="Inyanga Crackows +2"
    }

    sets.idle.PDT = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",left_ring="Defending Ring",right_ring="Patricius Ring",
        back="Moonbeam Cape",waist="Latria Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    sets.idle.MDT = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",left_ring="Defending Ring",right_ring="Vertigo Ring",
        back="Moonbeam Cape",waist="Latria Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    ---------------------------------------------------------------------------
    -- Idle sets with Avatar and Spirits --------------------------------------
    ---------------------------------------------------------------------------
    sets.idle.Avatar = set_combine(sets.idle, {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Caller's Pendant",left_ear="C. Palug Earring", right_ear="Enmerkar Earring",
        body="Beckoner's Doublet +1",hands="Lamassu Mitts +1",left_ring={ name="Varar Ring +1", bag="wardrobe3"},right_ring="Woltaris Ring",
        back=CCapePhysical, waist="Regal Belt", legs="Assiduity Pants +1", feet="Convoker's Pigaches +3"})
        
    -- Favor uses Empyrean instead of AF for Refresh --------------------------
    sets.idle.Avatar.Favor = {head="Beckoner's Horn +1"}

    ---------------------------------------------------------------------------
    -- Avatar TP set ----------------------------------------------------------
    ---------------------------------------------------------------------------
	sets.idle.Avatar.Melee = set_combine(sets.idle.Avatar, {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Summoner's Collar +2",left_ear="C. Palug Earring", right_ear="Enmerkar Earring",
        body="Beckoner's Doublet +1",hands="Lamassu Mitts +1",left_ring="C. Palug Ring",right_ring={ name="Varar Ring +1", bag="wardrobe4"},
        back=CCapePhysical, waist="Incarnation Sash", legs="Convoker's Spats +3", feet="Convoker's Pigaches +3"
    })

    sets.idle.PDT.Avatar = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",left_ear="Handler's Earring",right_ear="Handler's Earring +1",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",left_ring=LeftDarkRing,right_ring=RightDarkRing,
        back=CCapePhysical,waist="Selemnus Belt",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    sets.idle.Spirit = {main="Nirvana",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Caller's Pendant",left_ear="Rimeice Earring", right_ear="Enmerkar Earring",
        body="Beckoner's Doublet +1",hands="Inyanga Dastanas +2",left_ring={ name="Varar Ring +1", bag="wardrobe3"},right_ring={ name="Varar Ring +1", bag="wardrobe4"},
        back=CCapePhysical, waist="Incarnation Sash", legs="Assiduity Pants +1", feet="Convoker's Pigaches +3"}

    ---------------------------------------------------------------------------
    -- Perpetuation sets specific to Avatars and Day/Weather ------------------
    ---------------------------------------------------------------------------
    -- Caller's Bracer's halve the perp cost after other costs are ------------
    -- accounted for ----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.perp = {}
    sets.perp.Day = {hands="Beckoner's Bracers +1"}
    sets.perp.Weather = {neck="Caller's Pendant",hands="Beckoner's Bracers +1"}
    sets.perp.Carbuncle = set_combine( sets.idle, { hands="Asteria Mitts +1" })
    sets.perp.CaitSith = set_combine( sets.idle, { hands="Lamassu Mitts +1" })
    sets.perp.Diabolos = set_combine( sets.idle, { waist="Diabolos's Rope" })
    sets.perp.Alexander = set_combine( sets.idle, {})

    sets.perp.staff_and_grip = {}
    
    ---------------------------------------------------------------------------
    -- Physical Defense Set ---------------------------------------------------
    ---------------------------------------------------------------------------
    sets.defense.PDT = {
        head="Inyanga Tiara +2",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",left_ring="Defending Ring",right_ring="Patricius Ring",
        back="Moonbeam Cape",waist="Latria Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    ---------------------------------------------------------------------------
    -- Magical Defense Set ----------------------------------------------------
    ---------------------------------------------------------------------------
    sets.defense.MDT = { 
        head="Inyanga Tiara +2",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",left_ring="Defending Ring",right_ring="Vertigo Ring",
        back="Moonbeam Cape",waist="Latria Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    ---------------------------------------------------------------------------
    -- Catch me if you can! ---------------------------------------------------
    ---------------------------------------------------------------------------
    sets.Kiting = {feet="Herald's Gaiters"}
    
    ---------------------------------------------------------------------------
    -- Let's make sure we look pretty in Town ---------------------------------
    ---------------------------------------------------------------------------
    sets.idle.Town = {main="Nirvana",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Sanctity Necklace",left_ear="Etiolation Earring",right_ear="Enmerkar Earring",
        body="Councilor's Garb",hands="Inyanga Dastanas +2",left_ring="Inyanga Ring",right_ring="Woltaris Ring",
        back="Campestres's Cape",waist="Regal Belt",legs="Assiduity Pants +1",feet="Herald's Gaiters"
    }

-------------------------------------------------------------------------------
------ If we feel like doing some Melee for Afterglow -------------------------
-------------------------------------------------------------------------------
	
	sets.engaged = set_combine(sets.idle.Avatar, {
    main="Nirvana",
	sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Convoker's Horn +3",
    body="Con. Doublet +3",
	hands="Tali'ah Gages +2",
    legs="Convo. Spats +3",
    feet="Convo. Pigaches +3",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Hetairoi Ring",
    right_ring="Patricius Ring",
	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10',}},
	})

    sets.engaged.Avatar = sets.engaged
	
    sets.engaged.Avatar.Favor = sets.idle.Avatar.Favor

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    main="Nirvana",
	sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Convoker's Horn +3",
    body="Con. Doublet +3",
	hands="Tali'ah Gages +2",
    legs="Convo. Spats +3",
    feet="Convo. Pigaches +3",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Hetairoi Ring",
    right_ring="Patricius Ring",
	back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10',}},
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
        head="Beckoner's Horn +1",neck="Sanctity Necklace",left_ear="Etiolation Earring",right_ear="Gifted Earring",
        body="Beckoner's Doublet +1",hands="Shrieker's Cuffs",left_ring="Persis Ring",right_ring="Rahab Ring",
        back="Conveyance Cape",waist="Belisama's Rope",legs="Beckoner's Spats +1",feet="Beckoner's Pigaches +1"} 
		
	sets.precast.WS['Garland of Bliss'] = {
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Hydrocera",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet="Herald's Gaiters",
    neck="Eddy Necklace",
    waist="Luminary Sash",
    left_ear="Hecate's Earring",
    right_ear="Friomisi Earring",
    left_ring="Levia. Ring",
    right_ring="Levia. Ring",
    back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10',}},
}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            meleeSet = set_combine(meleeSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            meleeSet = set_combine(meleeSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            meleeSet = set_combine(meleeSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            meleeSet = set_combine(meleeSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            meleeSet = set_combine(meleeSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            meleeSet = set_combine(meleeSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        meleeSet = set_combine(meleeSet, sets.latent_refresh)
    end
    
    return meleeSet

    -- body
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end

if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed')
            disable('left_ring','right_ring','waist')
        else
            enable('left_ring','right_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

-- Handle CP Party Bonus Mantle

function job_handle_equipping_gear(playerStatus, eventArgs)
    if player.equipment.back == 'Mecisto. Mantle' then      
        disable('back')
    else
        enable('back')
    end    
end

-- Locks Weapon and Sub via keybind
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    --send_command('@input //gs enable all') --if you enable this disable auto page reset on dismiss in the lua
    set_macro_page(1, 16)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 16')
end
