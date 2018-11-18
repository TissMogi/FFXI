-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:
        
        Magic Burst         Toggle Magic Burst Mode  [Alt-`]
        Capacity Pts. Mode  Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle     Automatically locks desired equipset on file load
--]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180

    state.CP = M(false, "Capacity Points Mode")
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')  
    state.MagicBurst = M(false, 'Magic Burst')
    
-- Special Augmented Gear
    MerlinicHoodBurst = { name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+11%','Mag. Acc.+8',}}
    MerlinicShalwarBurst = { name="Merlinic Shalwar", augments={'Mag. Acc.+6','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
    MerlinicCrackowsBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','MND+1','Mag. Acc.+6','"Mag.Atk.Bns."+1',}}
    MerlinicCrackowsBurst2 = { name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+8%','"Mag.Atk.Bns."+15',}}
    
    MerlinicHoodDrain = { name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +4','INT+8','"Mag.Atk.Bns."+3',}}
    MerlinicCrackowsDrain = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +8','CHR+2','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}
    
    MerlinicJubbahDD = { name="Merlinic Jubbah", augments={'Mag. Acc.+5','"Fast Cast"+5','"Mag.Atk.Bns."+7',}}
    MerlinicShalwarDD = { name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Occult Acumen"+7','Mag. Acc.+10','"Mag.Atk.Bns."+11',}}
    MerlinicShalwarDD2 = { name="Merlinic Shalwar", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+4','INT+12','"Mag.Atk.Bns."+15',}}
    
    NanCape = { name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: Damage taken -5%',}}
    
    

    -- Additional local binds
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind ^, input /ma Sneak <stpc>')
    send_command('bind ^. input /ma Invisible <stpc>')
    send_command('bind @c gs c toggle CP')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ^a gs equip sets.idle')
    send_command('bind ^` input /item "Echo Drops" <me>')
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 10;input /item "Warp Ring" <me>')
    
    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !w')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @c')
    send_command('unbind @w')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +2"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +2", back="Nantosuelta's Cape"}
  
    -- Fast cast sets for spells
    
    sets.precast.FC = {
    --  /RDM --15
        --main="Oranyan",                   --7
        --sub="Clerisy Strap +1",           -- 3
        range="Dunna",                  -- 3%
        head="Vanya Hood",              -- 10%
        body=MerlinicJubbahDD,          -- 11%
        --hands="Merlinic Dastanas",        -- 6%
        legs="Geomancy Pants +2",       -- 13%
        feet="Regal Pumps +1",          -- 7%
        neck="Voltsurge Torque",        -- 4%
        left_ear="Loquacious Earring",      -- 2%
        right_ear="Etiolation Earring",      -- 01%
        left_ring="Kishar Ring",            -- 02%
        right_ring="Rahab Ring",             -- 04%
        back="Lifestream Cape",         -- 7%
        waist="Witful Belt",            -- 3%/(2)%
        }
------------------------------------------ 67% Total

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })
        
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        hands="Bagua Mitaines +1",
        feet="Mallquis Clogs +1"
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        left_ear="Mendi. Earring",          -- 5%
        back="Pahtli Cape",             -- 08%
        left_ring="Lebeche Ring",           --          +2%qm
        legs="Doyen Pants",             -- 15%
        feet="Vanya Clogs"              -- 15%      
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        --head=empty, 
        --body="Twilight Cloak"
        })

     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        }

    
    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------
    
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        --main="Oranyan",
        --sub="Clerisy Strap +1",
        head="Amalric Coif +1",
        --hands="Merlinic Dastanas",
        legs="Geomancy Pants +2",
        feet="Regal Pumps +1",
        --left_ear="Loquacious Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        back="Lifestream Cape",
        }
    
   sets.midcast.Geomancy = {
        main="Solstice",
        sub="Genmei Shield",
        range="Dunna",
        head="Azimuth Hood +1",
        body="Amalric Doublet",         -- conserve mp: 6
        hands="Geo. Mitaines +3",
        legs="Bagua Pants +1",
        feet="Azimuth Gaiters +1",
        --neck="Incanter's Torque",
        left_ear="Gifted Earring",
        right_ear="Calamitous Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Lifestream Cape",
        waist="Emphatikos Rope"         --waist="Austerity Belt +1",
        }
    
    sets.midcast.Geomancy.Indi = {
        main="Solstice",
        sub="Genmei Shield",
        range="Dunna",
        head="Azimuth Hood +1",
        body="Amalric Doublet",         -- conserve mp: 6
        hands="Geo. Mitaines +3",
        legs="Bagua Pants +1",
        feet="Azimuth Gaiters +1",
        --neck="Incanter's Torque",
        left_ear="Gifted Earring",
        right_ear="Calamitous Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Lifestream Cape",
        waist="Emphatikos Rope"         --waist="Austerity Belt +1",
        }

    ---------------------------------------------------------------------------
    -- Cure Potency Set ( Healing Magic Skill > MND ) -------------------------
    -- The Cap is 50% for Cure Potency II to take effect ----------------------
    ---------------------------------------------------------------------------
                                            -- Cure Pot.    Mnd     H.M. Skill  Conserve MP 
    sets.midcast.Cure = {
        main="Divinity",                    -- 15%
        sub="Ammurapi Shield",              --
        ammo="Pemphredo Tathlum",           --                                  +04
        head="Vanya Hood",                  -- 10%                              +06
        neck="Nodens Gorget",               -- 05%
        left_ear="Mendi. Earring",              -- 05%
        right_ear="Regal Earring",               --              +10
        body="Vanya Robe",                  --                      +20
        hands="Shrieker's Cuffs",           --                                  +07
        left_ring="Haoma's Ring",               --                      +08
        right_ring="Sirona's Ring",              --                      +10
        back="Solemnity Cape",              -- 07%          +8                  +05
        waist="Luminary Sash",              --              +10                 +04
        legs="Vanya Slops",                 --              +10                 +12
        feet="Vanya Clogs"                  -- 10%                              +06
        }
        --------------------------------Total: 52%                  +38         +44

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget",
        left_ring="Levia. Ring",
        right_ring="Levia. Ring"
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        main="Gada",
        ammo="Pemphredo Tathlum",
        head="Vanya Hood",
        body="Vanya Robe",
        feet="Vanya Clogs",
        --neck="Debilis Medallion",
        --left_ear="Beatific Earring",
        left_ring="Haoma's Ring",       -- cursna 15%
        right_ring="Haoma's Ring"
        })

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        --neck="Incanter's Torque",
        --left_ear="Augment. Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Perimede Cape",       --back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }
        
    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Blink'] = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = sets.midcast['Enhancing Magic']
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic']     
        
    sets.midcast.EnhancingDuration = {
        main="Bolelabunga",         --main="Oranyan",
        sub="Ammurapi Shield",      --sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        --body="Telchine Chas.",
        })
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",
        --waist="Gishdubar Sash",
        --back="Grapevine Cape",
        })
            
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        ammo="Pemphredo Tathlum",
        head="Umuthi Hat",
        legs="Doyen Pants",
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        --main="Vadose Rod",
        ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",
        waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        --left_ring="Sheltered Ring",
        })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Ischemia Chasu.",
        neck="Erra Pendant",
        left_ear="Hermetic Earring",
        right_ear="Regal Earring",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring",
        right_ring="Kishar Ring",
        back="Gwyddion's Cape",
        waist="Rumination Sash",
        legs="Inyanga Shalwar +2",
        feet="Bagua Sandals +1",
        } -- MND/Magic accuracy
    
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Venabulum",
        back=NanCape,
        }) -- INT/Magic accuracy

    sets.midcast['Dark Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Bagua Tunic +2",
        neck="Erra Pendant",
        left_ear="Hermetic Earring",
        right_ear="Regal Earring",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring",
        right_ring="Kishar Ring",
        back="Gwyddion's Cape",
        waist="Rumination Sash",
        legs="Inyanga Shalwar +2",
        feet="Bagua Sandals +1",                    --feet="Bokwus Boots"
        }
    
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        main="Rubicundity",
        ammo="Pemphredo Tathlum",
        head="Bagua Galero +2",
        neck="Sanctity Necklace",
        left_ear="Hermetic Earring",
        right_ear="Regal Earring",
        body="Bagua Tunic +2",
        hands="Jhakri Cuffs +2",
        left_ring="Jhakri Ring",
        right_ring="Vertigo Ring",       
        back="Gwyddion's Cape",
        waist="Fucho-no-Obi",
        legs=MerlinicShalwarDD,
        feet=MerlinicCrackowsDrain
        })
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        --feet="Regal Pumps +1"
        })

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
        main="Venabulum",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        neck="Sanctity Necklace",
        left_ear="Friomisi Earring",        
        right_ear="Regal Earring",
        body="Bagua Tunic +2",
        hands="Ea Cuffs",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",       
        back="Gwyddion's Cape",
        waist="Porous Rope",
        legs=MerlinicShalwarDD,
        feet=MerlinicCrackowsDrain
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        --main="Venabulum",
        --sub="Enki Strap",
        --legs=gear.Merlinic_MAcc_legs,
        --neck="Sanctity Necklace",
        --back="Aurist's Cape +1",
        --waist="Yamabuki-no-Obi",
        })

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
        main="Solstice",
        sub="Genmei Shield",
        --left_ring="Fenrir Ring +1",
        --right_ring="Fenrir Ring +1",
        })

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        --sub="Enki Strap",
        --body="Seidr Cotehardie",
        --legs=gear.Merlinic_MAcc_legs,
        --neck="Sanctity Necklace",
        })

    sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {
        --main="Solstice",
        --sub="Culminus",       
        --body="Seidr Cotehardie",
        --neck="Sanctity Necklace",
        --left_ring="Fenrir Ring +1",
        --right_ring="Fenrir Ring +1",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        --main=gear.Grioavolr_MB,
        --sub="Niobid Strap",
        --head=empty,
        --body="Twilight Cloak",
        --right_ring="Archon Ring",
        })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Bolelabunga",
        sub="Genmei Shield",
        ranged="Dunna",
        head="Befouled Crown",
        body="Jhakri Robe +2",
        hands="Bagua Mitaines +1",
        legs="Assid. Pants +1",
        feet="Geo. Sandals +3",
        neck="Loricate Torque +1",
        left_ear="Moonshade Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Woltaris Ring",
        back="Disperser's Cape",
        waist="Porous Rope",
        }
    
    sets.resting = set_combine(sets.idle, {
        --main="Chatoyant Staff",
        --waist="Shinjutsu-no-Obi +1",
        })

    sets.idle.DT = set_combine(sets.idle, {
        main="Divinity", --10/0
        sub="Genmei Shield",            --10/0
        body=MerlinicJubbahDD,          --2/0           --body="Mallquis Saio +1", --6/6
        hands="Geo. Mitaines +3",       --3/3
        feet="Azimuth Gaiters +1",      --4/0
        neck="Loricate Torque +1",      --6/6
        left_ear="Genmei Earring",          --2/0
        right_ear="Etiolation Earring",      --0/3
        left_ring="Defending Ring",
        right_ring="Patricius Ring",
        back="Moonbeam Cape",           --5/5
        })

    -- sets.idle.Weak = sets.idle.DT

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, { 
        -- Pet: -DT (37.5% to cap) / Pet: Regen 
        main="Sucellus",                -- 3/3
        sub="Genmei Shield",
        range="Dunna",                  -- 5/0
        head="Azimuth Hood +1",         -- 0/3
        hands="Geo. Mitaines +3",       -- 11/0
        left_ear="Handler's Earring",       -- 3*/0
        right_ear="Handler's Earring +1",    -- 4*/0
        feet="Bagua Sandals +1",        -- 0/3
        back=NanCape,   -- 5/10
        waist="Isa Belt" --3/1
        })
    ----------------------------------DT: 34, Regen: 18----------------

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        --body="Mallquis Saio +1", --6/6
        legs="Psycloth Lappas", --4/0
        neck="Loricate Torque +1", --6/6
        left_ring="Patricius Ring",
        right_ring="Vertigo Ring", --7/(-1)
        })

    -- .Indi sets are for when an Indi-spell is active.
--  sets.idle.Indi = set_combine(sets.idle, {legs="Bagua Pants +1"})
--  sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs="Bagua Pants +1"})
--  sets.idle.DT.Indi = set_combine(sets.idle.DT, {legs="Bagua Pants +1"})
--  sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {legs="Bagua Pants +1"})

    sets.idle.Town = set_combine(sets.idle, {
        main="Bolelabunga",
        sub="Genmei Shield",
        ranged="Dunna",
        head="Befouled Crown",
        body="Councilor's Garb",
        hands="Geo. Mitaines +3",
        legs="Assid. Pants +1",
        feet="Geo. Sandals +3",
        neck="Loricate Torque +1",
        left_ear="Moonshade Earring",
        right_ear="Etiolation Earring",
        left_ring="Patricius Ring",
        right_ring="Woltaris Ring",
        back="Disperser's Cape",
        waist="Porous Rope",
        })
        
    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {
        feet="Geomancy Sandals +3"
        }

    sets.latent_refresh = {
        waist="Fucho-no-obi"
        }
    
    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {        
        --head="Telchine Cap",
        --body="Onca Suit",
        --neck="Combatant's Torque",
        --left_ear="Cessance Earring",
        --right_ear="Telos Earring",
        --left_ring="Ramuh Ring +1",
        --right_ring="Ramuh Ring +1",
        --waist="Grunfeld Rope",
        --back="Relucent Cape",
        }


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
        head="Ea Hat",                  -- 06/06%       +38     +40     +33
        neck="Mizukage-no-Kubikazari",  -- 10%          +04     +00     +08
        left_ear="Hermetic Earring",        --              +03     +08     +08
        right_ear="Friomisi Earring",        --                              +06
        body="Ea Houppelande",          -- 08%/08%      +43     +42     +39
        hands="Ea Cuffs",               -- 05/05%       +35     +39     +30
        left_ring="Locus Ring",             -- 05%
        right_ring="Mujin Band",             -- 00%/05%
        back="Gwyddion's Cape",         --              +06     +02
        waist="Porous Rope",            --              +07     +05
        legs="Ea Slops",                -- 07%/07%      +43     +41     +36
        feet=MerlinicCrackowsDrain      --              +24     +34     +54
        }
    ------------------------------- Total: 41%/31%=71%  +203    +211    +214

    sets.buff.Doom = {
    --left_ring="Saida Ring", 
    --right_ring="Saida Ring", 
    --waist="Gishdubar Sash"
    }

    sets.Obi = {
    waist="Hachirin-no-Obi"
    }
    
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then 
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            --send_command('@timers d "'..indi_timer..'"')
            --indi_timer = spell.english
            --send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.skill == 'Elemental Magic' then
 --        state.MagicBurst:reset()
        end
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        end 
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end

    if buff == "doom" then
        if gain then           
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('left_ring','right_ring','waist')
        else
            enable('left_ring','right_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    send_command('@input //gs enable all')
    set_macro_page(1, 7)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 7')
end