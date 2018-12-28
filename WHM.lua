------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup variables for this job
-------------------------------------------------------------------------------------------------------------------
function user_setup()
    -------------------------------------------------------------------------------------------------------------------
    -- Initialization function that defines sets and variables to be used.
    -------------------------------------------------------------------------------------------------------------------
    -- F12 - Update currently equipped gear, and report current status.
    -- F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    -- F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    -- Alt-F12 - Turns off any emergency defense mode.
    -- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
    -- Alt-F10 - Toggles Kiting Mode.

    -- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
    state.OffenseMode:options('None', 'Normal', 'PDT', 'MDT')
    -- Win-F9 - Cycle Weaponskill Mode.
    state.WeaponskillMode:options('None', 'Acc')
    -- Ctrl-F11 - Cycle Casting Mode.
    state.CastingMode:options('None', 'Resistant')
    -- Ctrl-F12 - Cycle Idle Mode.
    state.IdleMode:options('None', 'PDT', 'MDT')
    -- Locks Weapon and Sub via keybind
    state.WeaponLock = M(false, 'Weapon Lock')
    send_command('bind @w gs c toggle WeaponLock')
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 11;input /item "Warp Ring" <me>')
    send_command('bind @c input /equipset 03;input /echo <rarr> Tele-Holla Warping!!;wait 11;input /item "Dim. Ring (Holla)" <me>')
    
    ---------------------------------------------------------------------------
    -- Augmented Gear Section -------------------------------------------------
    ---------------------------------------------------------------------------

    AlanusDD = { name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
    AlanusCure = { name="Alaunus's Cape", augments={'MND+20','MND+10','"Cure" potency +10%','Occ. inc. resist. to stat. ailments+10',}}
    
    ---------------------------------------------------------------------------
    -- Select the default Macro book and page based on subjob -----------------
    ---------------------------------------------------------------------------
    select_default_macro_book()
    set_lockstyle()
end

function init_gear_sets()
    ---------------------------------------------------------------------------
    -- Precast Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Fast Cast Sets for all Spells ( Cap:80% - SCH:70% - RDM:65% ) ----------
    ---------------------------------------------------------------------------
    sets.precast.FC = {
        main="Yagrush",             -- 20%
        ammo="Sapience Orb",        -- 02%
        head="Vanya Hood",          -- 10%
        neck="Orison Locket",       -- 05%
        left_ear="Etiolation Earring",  -- 01%
        right_ear="Loquac. Earring",     -- 02%  
        body="Inyanga Jubbah +2",   -- 14%
        hands="Fanatic Gloves",     -- 07% 
        left_ring="Rahab Ring",         -- 02%
        right_ring="Kishar Ring",        -- 04%
                                
        waist="Witful Belt",        -- 03%/03% quick magic
        legs="Ayanmo Cosciales +2", -- 06%
        feet="Regal Pumps +1"       -- 04% +1-3 unity ranking (counted 3)
    --------------------------- Total: 80% ------------------------------------
    }

    ---------------------------------------------------------------------------
    -- Healing Magic Casting Time ---------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
        main="Vadose Rod",          -- 5%
        legs="Ebers Pantaloons +1", --13%
        back="Disperser's Cape"     -- 5%
    ------------------ Healing Magic: 18% - [FastCast: 68% - Total: 86% --------
    })

    sets.precast.FC.RevivalMagic = sets.precast.FC['Healing Magic']
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    ---------------------------------------------------------------------------
    -- Cure Casting Time - ( Cap: 50% ) ---------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
                                              
        head="Piety Cap +1",            -- 13%
        left_ear="Mendi. Earring",      -- 05%
        right_ear="Nourish. Earring +1",-- 04%
        back="Pahtli Cape",             -- 08%
        legs="Doyen Pants",             -- 15%
        feet="Vanya Clogs"              -- 15%
    ------------------- Cure Casting Time: 67% [- FastCast: 68% Total: 135%]
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    ---------------------------------------------------------------------------
    -- Enhancing Magic Casting Time--------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash"
    })

    ---------------------------------------------------------------------------
    -- Stoneskin --------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
        head="Umuthi Hat", waist="Siegel Sash", legs="Doyen Pants"})

    ---------------------------------------------------------------------------
    -- Precast sets to enhance JAs --------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.JA['Benediction'] = {body="Piety Briault +3"}
    sets.precast.JA['Afflatus Solace'] = {body="Ebers Bliaud +1", back="Alaunus's Cape"}
    sets.precast.JA['Devotion'] = {head="Piety Cap +1"}
    
    sets.precast.JA['Sublimation'] = {
        ammo="Homiliary",
        head="Theophany Cap +2",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        body="Ebers Bliaud +1",
        hands="Ebers Mitts +1",
        left_ring="Woltaris Ring",
        right_ring="Persis Ring",
        legs="Perdition Slops",
        feet="Mallquis Clogs +1",
        waist="Porous Rope",
        back="Moonbeam Cape"
    }

-------------------------------------------------------------------------------
-- Midcast Sets ---------------------------------------------------------------
-------------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- Base midcast Conserve MP set. ( Caps: 100% - SCH,BLM: 75% - GEO: 69% ) -
    -- All other midcast sets will use this as a base set to make sure --------
    -- we are always casting at with as much conserver MP as possible ---------
    ---------------------------------------------------------------------------
    sets.midcast = {
        main="Rubicundity",         -- 02%
        sub="Thuellaic Ecu +1",     -- 04%
        ammo="Pemphredo Tathlum",   -- 03%
        head="Vanya Hood",          -- 06%
        neck="Reti Pendant",        -- 04%
        left_ear="Mendicant's Earring", -- 02% (Magnetic Earring 05)
        right_ear="Calamitous Earring",  -- 04%
        body="Witching Robe",       -- 05% (Kaykaus: 06, Chironic: 05, Vedic: 10)
        hands="Shrieker's Cuffs",   -- 07% (Thrift Gloves +1: 05, Kaykaus: 06)
        back="Solemnity Cape",      -- 05% (Fi Follet: 04, Aurist's: 1-5)
        waist="Austerity Belt +1",  -- 09%
        legs="Vanya Slops",         -- 12% (with augment C)
        feet="Vanya Clogs",         -- 06% (with augment C, Kaykaus: 06)
    --------------------------- Total: 69% ------------------------------------
    }

    ---------------------------------------------------------------------------
    -- Cure Potency II Set (Potency > Healing Magic Skill > MND ) -------------
    -- The Cap is 50% for Cure Potency II to take effect ----------------------
    ---------------------------------------------------------------------------
    sets.midcast.Cure = set_combine(sets.midcast, {
        main="Queller Rod",                 -- 10%/02%
        head="Ebers Cap +1",                -- 16%
        neck="Cleric's Torque +1",          -- 07%
        left_ear="Glorious Earring",        -- 00%/02%
        body="Theo. Briault +3",            -- 00%/06%
        hands="Theophany Mitts +3",         -- 00%/04%
        left_ring="Haoma's Ring",           
        right_ring="Sirona's ring",
        back=AlanusCure,                    -- 10%
        waist="Hachirin-no-Obi",
        legs="Ebers Pantaloons +1",
        feet="Vanya Clogs"                  -- 10%
    ----------------------------------- Cure: 53% - Cure II: 14% - Total: 64% -
    })

    ---------------------------------------------------------------------------
    -- Cure Set for Afflatus Solace -------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
        back=AlanusCure
    })

    ---------------------------------------------------------------------------
    -- Curaga Set (Potency > MND > Healing Magic Skill) -----------------------
    ---------------------------------------------------------------------------
    sets.midcast.Curaga = set_combine(sets.midcast, {
        main="Queller Rod",                 -- 10%/02%
        head="Ebers Cap +1",                -- 16%
        neck="Cleric's Torque +1",          -- 07%
        left_ear="Glorious Earring",        -- 00%/02%
        body="Theo. Briault +3",            -- 00%/06%
        hands="Theophany Mitts +3",         -- 00%/04%
        left_ring="Haoma's Ring",           
        right_ring="Sirona's ring",
        back=AlanusCure,                    -- 10%
        waist="Hachirin-no-Obi",
        legs="Ebers Pantaloons +1",
        feet="Vanya Clogs"                  -- 10%
    })

    ---------------------------------------------------------------------------
    -- Cursna - ( Based on Healing Magic Skill ) ------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Cursna = set_combine(sets.midcast, {
        main="Yagrush",
                             
        --neck="Malison Medallion",
        body="Vanya Robe", 
        hands="Fanatic Gloves",         -- cursna +15; HMS +9
        left_ring="Haoma's Ring",       -- cursna 15%
        right_ring="Menelaus's Ring",   -- cursna +25
        back=AlanusCure,                -- cursna +25
        legs="Theophany Pantaloons +2",
        feet="Vanya Clogs" --Gende. Galosh. +1
    })

    ---------------------------------------------------------------------------
    -- Enhancing Magic Set (Caps at 500)---------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast, {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
        neck="Melic Torque", 
        left_ear="Andoaa Earring",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        --back="Fi Follet Cape",
        back="Perimede Cape",
        waist="Austerity Belt +1",
        legs="Telchine Braconi",
        feet="Theophany Duckbills +3"
    --------------------------- Total: 511 ------------------------------------ 
    })
    
    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Blink'] = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = sets.midcast['Enhancing Magic']
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic']
    sets.midcast['Erase'] = set_combine(sets.midcast, {main="Yagrush", neck="Cleric's Torque +1"})
    sets.midcast['Healing Magic'] = set_combine(sets.midcast, {main="Yagrush"})
    
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Enhancing Torque",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        legs="Piety Pantaloons +3",
        feet="Ebers Duckbills +1"
    })

    ---------------------------------------------------------------------------
    -- Aquaveil ---------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Vadose Rod",
        head="Chironic Hat",
        --hands="Regal Cuffs"      -- Ou
        waist="Emphatikos Rope"    -- Xan Abyssea Vunkerl
        --legs="Shedir Seraweels"  -- Arch Ultima
    })

    ---------------------------------------------------------------------------
    -- Stoneskin --------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        head="Umuthi Hat",
        neck="Nodens Gorget",
        waist="Siegel Sash",
        --legs="Gendewitha Spats",
        --feet="Gendewitha Galoshes"
    })

    ---------------------------------------------------------------------------
    -- Auspice ----------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Ebers Duckbills +1"
    })

    ---------------------------------------------------------------------------
    -- Refresh ----------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        head="Amalric Coif +1"
        --waist="Gishdubar Sash",
        --feet="Inspirited Boots"
    })

    ---------------------------------------------------------------------------
    -- Regen - Potency: 58% - Duration: ---------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main="Bolelabunga",
        head="Inyanga Tiara +2",
        body="Piety Briault +3",
        hands="Ebers Mitts +1",
        legs="Th. Pantaloons +2"
    })

    ---------------------------------------------------------------------------
    -- Protect ----------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
        left_ring="Sheltered Ring",
        feet="Piety Duckbills +1"
    })

    ---------------------------------------------------------------------------
    -- Shell ------------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
        left_ring="Sheltered Ring",
        legs="Piety Pantaloons +3"
    })

    ---------------------------------------------------------------------------
    -- Divine Magic -----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Divine Magic'] = set_combine(sets.midcast, {
        main="Divinity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Vanya Robe",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Gwyddion's Cape",
        --waist="Rumination Sash", --I'd rather use Austerity Belt +1
        legs="Theophany Pantaloons +2",
        feet="Medium's Sabots"
        })

    ---------------------------------------------------------------------------
    -- Dark Magic -------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Dark Magic'] = set_combine(sets.midcast, {
    })

    ---------------------------------------------------------------------------
    -- Custom spell classes ---------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast.MndEnfeebles = set_combine(sets.midcast, {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Theo. Briault +3",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring +1",
        right_ring="Kishar Ring",
        back="Gwyddion's Cape",
        waist="Rumination Sash",
        legs="Inyanga Shalwar +2",
        feet="Theo. Duckbills +3"
    })

    sets.midcast.IntEnfeebles = set_combine(sets.midcast, {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Theo. Briault +3",
        hands="Inyan. Dastanas +2",
        left_ring="Stikini Ring +1",
        right_ring="Kishar Ring",
                      
        back="Gwyddion's Cape",
        waist="Rumination Sash",
        legs="Inyanga Shalwar +2",
        feet="Theo. Duckbills +3"
    })

    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

    ---------------------------------------------------------------------------
    -- Idle sets --------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.idle = {
    main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Homiliary",
    head="Befouled Crown",
    body="Piety Briault +3",
    hands="Inyan. Dastanas +2",
    legs="Assid. Pants +1",
    feet="Inyan. Crackows +2",
    neck="Loricate Torque +1",
    waist="Porous Rope",
    left_ear="Etiolation Earring",
    right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
    left_ring="Woltaris Ring",
    right_ring="Inyanga Ring",
    back=AlanusCure,
    }

    sets.idle.PDT = {
        sub="Genmei Shield",
        ammo="Sihirik",
        head="Ayanmo Zucchetto +2",
        neck="Loricate Torque +1",
        left_ear="Genmei Earring",
        right_ear="Odnowa Earring +1",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        left_ring="Defending Ring",
        right_ring="Patricius Ring",
        back="Moonbeam Cape",
        waist="Latria Sash",
        legs="Ayanmo Cosciales +2",
        feet="Ayanmo Gambieras +2"
    }
    
    sets.idle.MDT = {
        sub="Genmei Shield",
        ammo="Sihirik",
        head="Inyanga Tiara +2",
        neck="Loricate Torque +1",
        left_ear="Genmei Earring",
        right_ear="Odnowa Earring +1",
        body="Inyanga Jubbah +2",
        hands="Inyanga Dastanas +2",
        left_ring="Defending Ring", 
        right_ring="Vertigo Ring",
        back="Moonbeam Cape",
        waist="Latria Sash",
        legs="Inyanga Shalwar +2",
        feet="Inyanga Crackows +2"
    }
    
    ----------------------------- Total: 50% PDT--------------------------------

    --[[ sets.AfflatusSolace = sets.idle
    sets.AfflatusMisery = sets.idle.PDT ]]

    sets.idle.Town = {
        main="Yagrush",
        sub="Genmei Shield",
        ammo="Homiliary",
        head="Befouled Crown",
        body="Councilor's Garb",
        hands="Inyan. Dastanas +2",
        legs="Assid. Pants +1",
        feet="Herald's Gaiters",
        neck="Loricate Torque +1",
        waist="Porous Rope",
        left_ear="Etiolation Earring",
        right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        left_ring="Woltaris Ring",
        right_ring="Inyanga Ring",
        back=AlanusCure,
    }
    
    --sets.idle.Weak = sets.idle.PDT
    sets.resting = sets.idle

    ---------------------------------------------------------------------------
    -- Defense sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.MDT

    sets.Kiting = {feet="Herald's Gaiters"}

    ---------------------------------------------------------------------------
    -- Engaged sets -----------------------------------------------------------
    ---------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    ---------------------------------------------------------------------------
    -- Basic set for if no TP weapon is defined. ------------------------------
    ---------------------------------------------------------------------------
    sets.engaged = set_combine( sets.defense.PDT, {
        main="Yagrush",
        sub="Genmei Shield",
                               
        head="Ayanmo Zucchetto +2",
        neck="Sanctity Necklace",
        left_ear="Bladeborn Earring",
        right_ear="Steelflash Earring",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        left_ring="Varar Ring +1",
        right_ring="Begrudging Ring",
        back=AlanusDD,
        legs="Ayanmo Cosciales +2",
        feet="Ayanmo Gambieras +2",
        waist="Windbuffet Belt +1",
    })
    
    sets.engaged.wl = set_combine( sets.engaged, sets.defense.PDT, {
        sub="Ammurapi Shield"
    })
    
    ---------------------------------------------------------------------------
    -- Weaponskill sets -------------------------------------------------------
    ---------------------------------------------------------------------------
    gear.default.weaponskill_neck  = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = sets.engaged
    
    sets.precast.WS['Mystic Boon'] = {
    main="Yagrush",
    sub="Genmei Shield",
    ammo="Hydrocera",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
    }
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

--[[ function job_buff_change(name,gain)
    if name == "Afflatus Misery" and gain then
        send_command('gs c set IdleMode "PDT"')
    end
    if name == "Afflatus Solace" and gain then
        send_command('gs c set IdleMode "None"')
    end
end ]]

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    if player.equipment.back == 'Mecisto. Mantle' then
        disable('back')
    else
        enable('back')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


--[[ function customize_idle_set(idleSet)
    if buffactive['Afflatus Solace'] then
        idleSet = sets.AfflatusSolace
    elseif buffactive['Afflatus Misery'] then
        idleSet = sets.AfflatusMisery
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end ]]

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts =
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']

        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
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

-- Locks Weapon and Sub via keybind
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    send_command('@input //gs enable all')
    if player.sub_job == 'RDM' then
        set_macro_page(1, 10)    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 10')
end
