-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'MP')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')
    state.CapacityPoints = M(false, 'CapacityPoints')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    -- Special Augmented Gear
    MerlinicHoodBurst = { name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+11%','Mag. Acc.+8',}}
    MerlinicShalwarBurst = { name="Merlinic Shalwar", augments={'Mag. Acc.+6','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
    MerlinicCrackowsBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','MND+1','Mag. Acc.+6','"Mag.Atk.Bns."+1',}}
    MerlinicCrackowsBurst2 = { name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+8%','"Mag.Atk.Bns."+15',}}
    
    MerlinicHoodDrain = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +10','DEX+3',}}
    MerlinicJubbahDrain = { name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Drain" and "Aspir" potency +7','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+2',}}
    MerlinicDastanasDrain = { name="Merlinic Dastanas", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Drain" and "Aspir" potency +9','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
    MerlinicCrackowsDrain = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +8','CHR+2','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}

    MerlinicShalwarDD = { name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Occult Acumen"+7','Mag. Acc.+10','"Mag.Atk.Bns."+11',}}
    MerlinicShalwarDD2 = { name="Merlinic Shalwar", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+4','INT+12','"Mag.Atk.Bns."+15',}}  
    
    MerlinicDastanasFC = { name="Merlinic Dastanas", augments={'Mag. Acc.+8','"Fast Cast"+5','CHR+7','"Mag.Atk.Bns."+8',}}
    TaranusCapeDD = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
    TaranusCapeFC = { name="Taranus's Cape", augments={'"Fast Cast"+10',}}
    
    Lathi = { name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}}
    
    

    
    -- Additional local binds
    -- CTRL + `
    send_command('bind ^` input /ma Stun <t>')
    -- Windows + `
    send_command('bind @` gs c toggle MagicBurst')
    -- ALT + `
    send_command('bind !` gs c  toggle CapacityPoints; gs disable back')
    -- CTRL a
    send_command('bind ^a gs equip sets.idle')
    --send_command('bind ^; gs equip sets.Capacity')
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 10;input /item "Warp Ring" <me>')    
    
    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
    send_command('unbind !`')
end

-- Organizer Gear to keep in inv for specific job.
organizer_items = {
    echos="Echo Drops",
    remedy="Remedy",
    holy="Holy Water",
    food="Pear Crepe",
    orb="Macrocosmic Orb"
    }

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
    feet="Wicce Sabots +1"
    }

    sets.precast.JA.Manafont = {
    body="Archmage's Coat +3"
    }
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    ---------------------------------------------------------------------------
    -- Precast Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Fast Cast Sets for all Spells ( Cap:80% - SCH:70% - RDM:65% ) ----------
    ---------------------------------------------------------------------------
    sets.precast.FC = {
        ammo="Sapience Orb",            -- 02%
        head="Vanya Hood",              -- 10%
        neck="Voltsurge Torque",        -- 04%
        left_ear="Etiolation Earring",  -- 02%
        right_ear="Loquac. Earring",    -- 01%  
        body=MerlinicJubbahDrain,       -- 06%
        hands="Gendewitha Gages +1",    -- 07%
        left_ring="Rahab Ring",         -- 02%
        right_ring="Kishar Ring",       -- 04%
        back=TaranusCapeFC,             -- 10%
        waist="Witful Belt",            -- 03%/03% quick magic
        legs="Gyve Trousers",           -- 04%
        feet="Regal Pumps +1"           -- 07%
    ------------------------------- Total: 62% / 3% quick -----------------------
    }

    --[[    ammo="Impatiens",
        head="Vanya Hood",left_ear="Loquacious Earring",right_ear="Etiolation Earring",
        body="Shango Robe",hands="Helios Gloves", left_ring="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Gyve Trousers",feet="Regal Pumps +1"}]]

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash"
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
    --neck="Stoicheion Medal"
    hands="Mallquis Cuffs +1"
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    --body="Heka's Kalasiris", 
    right_ear="Mendi. Earring",          -- 5%
    back="Pahtli Cape",             -- 08%
    left_ring="Lebeche Ring",           --          +2%qm
    legs="Doyen Pants",             -- 15%
    feet="Vanya Clogs"              -- 15%
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    --[[    head="Hagondes Hat",neck="Asperity Necklace",left_ear="Bladeborn Earring",right_ear="Steelflash Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",left_ring="Rajas Ring",right_ring="Icesoul Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",left_ear="Friomisi Earring",right_ear="Strophadic Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",left_ring="Icesoul Ring",right_ring="Acumen Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"]]}
        
    sets.precast.WS['Myrkr']  = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Elis Tome",
        head="Amalric Coif +1",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Evans Earring",
        body="Spaekona's Coat +3",
        hands="Shrieker's Cuffs",
        left_ring="Sangoma Ring",
        right_ring="Persis Ring",
        back="Bane Cape",
        waist="Belisama's Rope",
        legs="Spaekona's Tonban +3",
        feet="Telchine Pigaches"
        --------------------------------Total: 2204 MP = 1322 Myrkr~
    }       
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        --head="Nahtirah Hat",
        --right_ear="Loquacious Earring",
        --left_ear="Etiolation Earring",
        --body="Vanir Cotehardie",
        --hands="Bokwus Gloves",
        --left_ring="Rahab Ring",
        --back="Swith Cape",
        --waist="Goading Belt",
        --legs="Hagondes Pants",
        --feet="Hagondes Sabots"
        }
        
    ---------------------------------------------------------------------------
    -- Cure Potency Set ( Healing Magic Skill > MND ) ----------------------
    -- The Cap is 50% for Cure Potency II to take effect ----------------------
    ---------------------------------------------------------------------------
    sets.midcast.Cure = {main="Lathi",sub="Enki Strap",
                                            -- Cure Pot.    Mnd     H.M. Skill  Conserve MP 
        ammo="Pemphredo Tathlum",           --                                  +04
        head="Vanya Hood",                  -- 10%                              +06
        neck="Nodens Gorget",               -- 05%
        left_ear="Mendi. Earring",              -- 05%
        right_ear="Regal Earring",               --              +10
        body="Vanya Robe",                  --                      +20
        hands="Shrieker's Cuffs",           --                                  +07
        left_ring="Lebeche Ring",               -- 03%
        right_ring="Sirona's Ring",              --                      +10
        back="Solemnity Cape",              -- 07%                              +05
        waist="Austerity Belt +1", --waist="Luminary Sash",              --              +10                 +04
        legs="Gyve Trousers",               -- 10%
        feet="Vanya Clogs"                  -- 10%                              +06
        }
        --------------------------------Total: 50%                  +30         +32
        
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget",
        left_ring="Levia. Ring",
        right_ring="Levia. Ring"
        })

    sets.midcast['Enhancing Magic'] = {
        head="Telchine Cap",
        neck="Enhancing Torque",
        left_ear="Andoaa Earring",
        right_ear="Regal Earring",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        waist="Embla Sash",
        legs="Telchine Braconi",
        feet="Telchine Pigaches"
        }

    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Blink'] = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = sets.midcast['Enhancing Magic']
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic']
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Inspirited Boots"
        })
    sets.midcast['Phalanx'] = sets.midcast['Enhancing Magic']
        
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
    head="Amalric Coif +1", 
    --feet="Inspirited Boots", 
    --waist="Gishdubar Sash"
    })
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat",
    waist="Siegel Sash",
    legs="Doyen Pants"
    })

    sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        neck="Sorcerer's Stole +2",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Spaekona's Coat +3",
        hands="Archmage's Gloves +3",
        left_ring="Stikini Ring +1",
        right_ring="Kishar Ring",
        back=TaranusCapeDD,
        waist="Rumination Sash",
        legs="Psycloth Lappas",
        feet="Archmage's Sabots +3"
        }
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Erra Pendant",
        left_ear="Hecate's Earring",
        right_ear="Regal Earring",
        body="Archmage's Coat +3",
        hands="Archmage's Gloves +3",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
        waist="Yamabuki-no-Obi",
        legs="Spaekona's Tonban +3",
        feet="Archmage's Sabots +3"
        }

    sets.midcast.Drain = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Erra Pendant",
        left_ear="Hecate's Earring",
        right_ear="Regal Earring",
        body=MerlinicJubbahDrain,
        hands=MerlinicDastanasDrain,
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back=TaranusCapeDD,
        waist="Fucho-no-Obi",
        legs="Spaekona's Tonban +3",
        feet=MerlinicCrackowsDrain
        }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Archmage's Petasos +3",
        neck="Sorcerer's Stole +2",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Spaekona's Coat +3",
        hands="Archmage's Gloves +3",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back=TaranusCapeDD,
        waist="Luminary Sash",
        legs="Archmage's Tonban +3",
        feet="Archmage's Sabots +3"
        }

    --sets.midcast.BardSong = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
    --    head="Nahtirah Hat",neck="Weike Torque",left_ear="Psystorm Earring",right_ear="Lifestorm Earring",
    --    body="Vanir Cotehardie",hands="Yaoyotl Gloves",left_ring="Strendu Ring",right_ring="Sangoma Ring",
    --    back="Bane Cape",legs="Bokwus Slops",feet="Bokwus Boots"}

    -- Elemental Magic sets
    -- INT 116+246, MAB 311
    sets.midcast['Elemental Magic'] = {
                                        --              INT     MAC     MAB     Ele Skill           
        main="Lathi",                   --              +27     +15     +63
        sub="Enki Strap",               --              +10     +10
        ammo="Pemphredo Tathlum",       --              +04     +08     +04
        head="Archmage's Petasos +3",   --              +34     +43     +55
        neck="Sorcerer's Stole +2",     --              +12     +45     +05
        left_ear="Friomisi Earring",    --                              +10
        right_ear="Regal Earring",      --              +10     +set    +07
        body="Archmage's Coat +3",      --              +46     +40     +52
        hands="Archmage's Gloves +3",   --              +36     +38     +50
        left_ring="Shiva Ring +1",      --              +09             +03
        right_ring="Shiva Ring +1",     --              +09             +03
        back=TaranusCapeDD,             --              +30     +20     +10
        waist="Yamabuki-no-Obi",        --              +06     +02     +05
        legs="Archmage's Tonban +3",    --              +50     +46     +58
        feet="Archmage's Sabots +3"     --              +30     +42     +54
    ------------------------------- Total:              +313    +309    +379    +544(total skill not checked)
        }

        sets.midcast['Elemental Magic'].MP = {
                                        --              INT     MAC     MAB     Ele Skill       
        main="Lathi",                   --              +27     +15     +63
        sub="Enki Strap",               --              +10     +10
        ammo="Pemphredo Tathlum",       --              +04     +08     +04
        head="Archmage's Petasos +3",   --              +34     +43     +55
        neck="Sorcerer's Stole +2",     --              +12     +45     +05
        left_ear="Friomisi Earring",    --                              +10
        right_ear="Regal Earring",      --              +10     +set    +07
        body="Spaekona's Coat +3",      --              +39     +55
        hands="Archmage's Gloves +3",   --              +36     +38     +50
        left_ring="Shiva Ring +1",      --              +09             +03
        right_ring="Shiva Ring +1",     --              +09             +03
        back=TaranusCapeDD,             --              +30     +20     +10
        waist="Yamabuki-no-Obi",        --              +06     +02     +05
        legs="Archmage's Tonban +3",    --              +50     +46     +58
        feet="Archmage's Sabots +3"     --              +30     +42     +54
    ------------------------------- Total:              +306    +324    +327    +520
        }        

    ---------------------------------------------------------------------------
    -- Magic Burst Set for all Spells ( Needed for Tier 1 Cap:40% ) -----------
    ---------------------------------------------------------------------------
    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {
                                        -- MB%          INT     MAC     MAB    Ele Skill
        main="Lathi",                   --              +27     +15     +63
        sub="Enki Strap",               --              +10     +10
        ammo="Pemphredo Tathlum",       --              +04     +08     +04
        head="Ea Hat +1",               -- 07/07%       +43     +50     +38
        neck="Sorcerer's Stole +2",     -- 10%          +15     +55     +07
        left_ear="Friomisi Earring",    --                              +10
        right_ear="Regal Earring",      --              +10     +set    +07
        body="Ea Houppelande +1",       -- 09%/09%      +48     +52     +44
        hands="Archmage's Gloves +3",   -- 20%          +36     +38     +50
        left_ring="Shiva Ring +1",      --              +09             +03
        right_ring="Mujin Band",        -- 00%/05%
        back=TaranusCapeDD,             -- 05%          +30     +20     +10
        waist="Porous Rope",            --              +07     +05
        legs="Ea Slops",                -- 07%/07%      +43     +41     +36
        feet=MerlinicCrackowsDrain      --              +24     +34     +54
    ------------------------------- Total: 58%/28%=68%  +256    +301    +259
        })
    
    sets.midcast["Death"] = {
        head="Archmage's Petasos +3",
        neck="Erra Pendant",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        body="Spaekona's Coat +3",
        hands="Archmage's Gloves +3",
        left_ring="Sangoma Ring",
        right_ring="Persis Ring",
        back=TaranusCapeDD,
        waist="Yamabuki-no-Obi",
        legs="Spaekona's Tonban +3",
        feet="Archmage's Sabots +3"
    }

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
    --sub="Wizzan Grip"
    })
    
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {
    --sub="Wizzan Grip"
    })
    
    sets.midcast['Elemental Magic'].LowTierNuke = set_combine(sets.midcast['Elemental Magic'], {
        --sub="Benthos Grip",
        --head="Mallquis Chapeau +1",
        --body="Mallquis Saio +1",
        --hands="Mallquis Cuffs +1",
        --legs="Mallquis Trews +1",
        --feet="Mallquis Clogs +1"
        })

    -- Minimal damage gear for procs.
    --[[sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Niobid Strap",ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate Collar",left_ear="Bloodgem Earring",right_ear="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",left_ring="Sheltered Ring",right_ring="Paguroidea Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}]]


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = sets.idle
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi",sub="Enki Strap",ammo="Sihirik",
        head="Befouled Crown",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        body="Jhakri Robe +2",
        hands="Shrieker's Cuffs",
        left_ring="Stikini Ring +1",
        right_ring="Woltaris Ring",
        back=TaranusCapeDD,
        waist="Porous Rope",
        legs="Assid. Pants +1",
        feet="Mallquis Clogs +1"
        }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    --sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",ammo="Impatiens",
    --    head="Nahtirah Hat",neck="Loricate Collar",left_ear="Bloodgem Earring",right_ear="Loquacious Earring",
    --    body="Hagondes Coat",hands="Yaoyotl Gloves",left_ring="Defending Ring",right_ring=gear.DarkRing.physical,
    --    back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = sets.idle
        --{main="Bolelabunga",sub="Genmei Shield",ammo="Sihirik",
        --head="Befouled Crown", 
        --neck="Sanctity Necklace", 
        --left_ear="Etiolation Earring",
        --right_ear="Moonshade Earring",
        --body="Archmage's Coat +3", 
        --hands="Shrieker's Cuffs",
        --left_ring="Vertigo Ring",
        --right_ring="Patricius Ring",
        --back="Disperser's Cape", 
        --waist="Porous Rope", 
        --legs="Assid. Pants +1", 
        --feet="Mallquis Clogs +1"
    
    -- Town gear.
    sets.idle.Town = {body="Councilor's Garb",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {
        --main="Earth Staff",
        --sub="Zuuxowu Grip",
        head="Befouled Crown",
        neck="Loricate Torque +1",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        body=MerlinicJubbahDrain,
        hands="Shrieker's Cuffs",
        left_ring="Defending Ring",
        right_ring="Patricius Ring",
        back="Moonbeam Cape",
        waist="Porous Rope",
        legs="Artsieq Hose",
        feet="Mallquis Clogs +1"
        }

    sets.defense.MDT = {
        --ammo="Demonry Stone",
        head="Vanya Hood",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        body="Jhakri Robe +2",
        hands="Shrieker's Cuffs",
        left_ring="Defending Ring",
        right_ring="Vertigo Ring",
        back="Moonbeam Cape",
        waist="Porous Rope",
        legs="Assid. Pants +1",
        feet="Mallquis Clogs +1"
        }

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {
    feet="Wicce Sabots +1"
    }
    
    sets.capacity_points = {back="Mecisto. Mantle"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {main="Lathi",sub="Enki Strap",ammo="Sihirik",
                                    -- Accuracy     Double Att      Triple Att      Quad Att
    head="Jhakri Coronal +2",       -- 44
    neck="Sanctity Necklace",       -- 10
    left_ear="Steelflash Earring",  -- 08           7%
    right_ear="Bladeborn Earring",
    body="Jhakri Robe +2",          -- 46
    hands="Jhakri Cuffs +2",        -- 43
    left_ring="Defending Ring",
    right_ring="Hetairoi Ring",     --                              2
    back=TaranusCapeDD,
    waist="Windbuffet Belt +1",     --                              2               2
    legs="Jhakri Slops +2",         -- 45
    feet="Jhakri Pigaches +2"       -- 42           7               4               2
    ----------------------------Total= 238
    }
    

    --// Elemental Obi
    sets.Obi = { waist = "Hachirin-no-Obi"}
    
    --// Capacity Ring
    sets.Capacity = { left_ring = "Capacity Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'MP' then
            classes.CustomClass = 'MP'
        end
    end
end
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
    if spell.skill == 'Elemental Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.Obi)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            --state.MagicBurst:reset()
        end
    end
    if state.CapacityPoints.value then
        equip(sets.capacity_points)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
    if state.CapacityPoints.value then
        equip(sets.capacity_points)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        -- No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    send_command('@input //gs enable all')
    set_macro_page(1, 15)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 15')
end