-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
-- Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
-- Alt-F9 - Cycle Ranged Mode.
-- Win-F9 - Cycle Weaponskill Mode.
-- F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
-- F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
-- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
-- Alt-F12 - Turns off any emergency defense mode.
-- Alt-F10 - Toggles Kiting Mode.
-- Ctrl-F11 - Cycle Casting Mode.
-- F12 - Update currently equipped gear, and report current status.
-- Ctrl-F12 - Cycle Idle Mode.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    -- Include Organizer addon.
    include('organizer-lib')
end

function job_setup()
    state.Buff['Restraint'] = buffactive['restraint'] or false
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
    -- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
    state.OffenseMode:options('GA', 'GS', 'Polearm','AxeShield', 'SwordShield', 'ClubShield', 'DualWield', 'TH')
    -- Ctrl-F9 - Cycle Hybrid Mode.
    state.HybridMode:options('Normal', 'Accuracy', 'LightPDT', 'PDT')
    -- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
    state.PhysicalDefenseMode:options('Normal','PDT')

    ---------------------------------------------------------------------------
    -- Additional local binds (! = alt, @ = windows, ^ = ctrl) ----------------
    ---------------------------------------------------------------------------
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind !- gs c cycle WeaponMode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind @z input /mount fenrir')

    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
--- ! = alt, @ = windows, ^ = ctrl
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @z')
end

-- Organizer Gear to keep in inv for specific job.
organizer_items = {
    remedy="Remedy",
    holy="Holy Water",
    food="Grape Daifuku",
    gsword1="Montante +1"
    }

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets -----------
    --------------------------------------

    ---------------------------------------------------------------------------
    -- Precast Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Job Abilities ----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.JA['Call Wyvern']    = { }                     --body="Pteroslaver Mail +3", neck="Dragoon's Collar", hands="Crusher Gauntlets", back="Updraft Mantle", legs="Vishap Brais +3", feet="Pteroslaver Greaves +3"
    
	sets.precast.JA['Ancient Circle'] = { }                     --legs="Vishap Brais +3"
	
	sets.precast.JA['Berserk'] = {
	head="Sulevia's Mask +2",
    body="Pummeler's Lorica +3",
    hands="Sulevia's Gauntlets +2",
    --legs="Arke Cosciales",
    feet="Agoge Calligae +1",                                   --feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect',}},
    neck="War. Beads +2",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
    left_ring="Defending Ring",
    --right_ring="Moonbeam Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},   --back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.JA['Aggressor'] = {
	head="Pummeler's Mask +2",                                  --head="Pummeler's Mask +3",
    body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
    hands="Sulevia's Gauntlets +2",
    --legs="Arke Cosciales",
    feet="Sulevia's Leggings +2",
    neck="War. Beads +2",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
    left_ring="Defending Ring",
    --right_ring="Moonbeam Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},   --back="Solemnity Cape",
	}
	
	sets.precast.JA['Mighty strikes'] = { hands="Agoge Mufflers +1" }   --hands="Agoge Mufflers +3"
	
	sets.precast.JA['Warcry'] = { head = "Agoge Mask +1" }      --head = "Agoge Mask +3"
	
	sets.precast.JA['Tomahawk'] = { ammo = "Throwing Tomahawk",feet = "Agoge Calligae +1", body="Valorous Mail", waist ="Chaac Belt" }    --feet = "Agoge Calligae +3"
	
	sets.precast.JA['Retaliation'] = {
    ammo="Sapience Orb",
    head="Pummeler's Mask +2",                                  --head="Pummeler's Mask +3",
    body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Pummeler's Mufflers +2",
    legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},    --feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",                                  --neck="Moonlight Necklace",
    waist="Chaac Belt",
    left_ear="Friomisi Earring",
    right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back="Moonbeam Cape",
	}
	
	sets.precast.JA['Restraint'] = { hands = "Boii Mufflers +1"}
	
	sets.precast.JA['Blood Rage'] = { body ="Boii Lorica +1" }
	
	sets.precast.JA['Brazen Rush'] = { body ="Boii Lorica +1" }
	
	sets.precast.JA['Provoke'] = {
    ammo="Sapience Orb",
    head="Pummeler's Mask +2",                                  --head="Pummeler's Mask +3",
    body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Pummeler's Mufflers +2",                             --hands="Pummeler's Mufflers +3",
    legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},    --feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",                                  --neck="Moonlight Necklace",
    waist="Chaac Belt",
    left_ear="Friomisi Earring",
    right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
    left_ring="Apeile Ring",
    right_ring="Apeile Ring +1",
    back="Mubvumbamiri Mantle",
    }
    -- Total Enmity: +92 --
	

    ---------------------------------------------------------------------------
    -- Spells -----------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.FC = {
        ammo="Sapience Orb",
        ammo="Sapience Orb",
        head="Sulevia's Mask +2",
        body={ name="Odyss. Chestplate", augments={'"Fast Cast"+3','INT+13',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+6','MND+7',}},
        feet={ name="Odyssean Greaves", augments={'Mag. Acc.+2','"Fast Cast"+5','CHR+3','"Mag.Atk.Bns."+14',}},
        neck="Voltsurge Torque",
        waist="Flume Belt +1",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Lebeche Ring",
        right_ring="Rahab Ring",
        back="Moonbeam Cape",
    -- Total 37% -------------------------------------------------------------
--[[    --head="Arke Zuchetto",
    body="Odyssean Chestplate",                                --body={ name="Odyssean Chestplate", augments={'"Fast Cast"+3','MND+9',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    --legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet="Odyssean Greaves",                                    --feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+5','AGI+2',}},
    neck="Voltsurge Torque",
    waist="Flume Belt +1",
    left_ear="Loquacious Earring",
    right_ear="Etiolation Earring",
    left_ring="Lebeche Ring",                                   --left_ring="Moonbeam Ring",
    right_ring="Rahab Ring",
    back="Moonbeam Cape",--]]
	}

    ---------------------------------------------------------------------------
    -- Midcast Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.midcast['Blue Magic'] = {
	--ammo="Impatiens",
    --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    --body={ name="Eschite Breast.", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    hands="Pummeler's Mufflers +2",
    --legs={ name="Eschite Cuisses", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},    --feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",                                  --neck="Moonlight Necklace",
    --waist="Ninurta's Sash",
    left_ear="Friomisi Earring",
    right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
    left_ring="Apeile Ring +1",
    right_ring="Apeile Ring",
    --back={ name="Cichol's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast['Ninjutsu'] = sets.midcast['Blue Magic']
	
	sets.midcast['Healing Magic'] = {
    --ammo="Impatiens",
    --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    --legs={ name="Eschite Cuisses", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},    --feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",                                  --neck="Moonlight Necklace",
    --waist="Ninurta's Sash",
    left_ear="Nourish. Earring +1",
    right_ear="Mendi. Earring",
    --right_ring="Evanescence Ring",
    --right_ring="Moonbeam ring",
    --back={ name="Cichol's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast['Dark Magic'] = sets.precast.JA['Provoke']
	

    ---------------------------------------------------------------------------
    -- Weapon Skills (Default) ------------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.WS = {}

    ---------------------------------------------------------------------------
    -- Specific Weaponskills --------------------------------------------------
    ---------------------------------------------------------------------------
    sets.precast.WS['Geirskogul'] = {}
    
    -- Fivefold physical attack, 73~85% STR -----------------------------------
	sets.precast.WS['Resolution'] = {
	    ammo="Seeth. Bomblet +1",
        head={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}},
        body={ name="Argosy Hauberk +1", augments={'STR+12','Attack+20','"Store TP"+6',}},
        hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
        legs={ name="Argosy Breeches +1", augments={'STR+12','Attack+25','"Store TP"+6',}},
        feet="Pummeler's Calligae +2",                              --legs={ name="Argosy Breeches +1", augments={'STR+12','Attack+25','"Store TP"+6',}},
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['King\'s Justice'] = sets.precast.WS['Resolution']
    
    -- Fourfold physical attack, 73~85% VIT -----------------------------------
	sets.precast.WS['Upheaval'] = {
	    ammo="Knobkierrie",
        head="Sulevia's Mask +2",                                   --head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pummeler's Lorica +3",
        hands="Sulevia's Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Rng.Atk.+14','VIT+10','Weapon skill damage +6%',}},  --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",                                 --right_ring="Epaminondas's Ring",
        back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
	}
    
    -- Threefold physical attack, 50% STR ------------------------------------
	sets.precast.WS['Raging Rush'] = {
	    ammo="Seeth. Bomblet +1",                                   --ammo="Yetshila +1",
        head="Boii Mask +1",
        body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                                    --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck="War. Beads +2",
        waist="Grunfeld Rope",
        left_ear="Thrud Earring",                                   --left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}, --back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	}
    
    -- Fivefold physical attack, 50% STR -------------------------------------
	sets.precast.WS['Rampage'] = {
	    ammo="Seeth. Bomblet +1",                                   --ammo="Yetshila +1",
        head="Boii Mask +1",
        body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                                    --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck="War. Beads +2",
        waist="Grunfeld Rope",
        left_ear="Thrud Earring",                                   --left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}, --back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	}
    
    -- Fourfold physical attack, 60% STR -------------------------------------
	sets.precast.WS['Vorpal Blade'] = {
	    ammo="Seeth. Bomblet +1",                                   --ammo="Yetshila +1",
        head="Boii Mask +1",
        body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                                    --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck="War. Beads +2",
        waist="Grunfeld Rope",
        left_ear="Thrud Earring",                                   --left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Begrudging Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}, --back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	}
    
    -- Twofold physical attack, 100% STR -------------------------------------
	sets.precast.WS['Impulse Drive'] = {
	    ammo="Knobkierrie",
        head={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}}, --head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pummeler's Lorica +3",
        hands="Flamma Manopolas +2",
        legs="Argosy Breeches +1",
        feet="Boii Calligae +1",
        neck="War. Beads +2",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Ishvara Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",                                 --right_ring="Epaminondas's Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Vorpal Thrust'] = sets.precast.WS['Impulse Drive']
    
    --Fourfold physical attack, 73~85% STR -----------------------------------
	sets.precast.WS['Stardiver'] = {
	    head={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}},
        body={ name="Argosy Hauberk +1", augments={'STR+12','Attack+20','"Store TP"+6',}},
        hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
        legs="Pummeler's Cuisses +2",                                 --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Penta Thrust'] = sets.precast.WS['Stardiver']
    
    -- Sixfold physical attack, 30% STR / 30% MND ---------------------------
		sets.precast.WS['Hexa Strike'] = {
	    ammo="Seeth. Bomblet +1",                                   --ammo="Yetshila +1",
        head="Boii Mask +1",
        body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                               --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Begrudging Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}, --back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	}
    
    -- Twofold physical attack, 50% STR / 50% MND --------------------------
	sets.precast.WS['Savage Blade'] = {
	    ammo="Knobkierrie",
        head="Sulevia's Mask +2",                                   --head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pummeler's Lorica +3",
        hands="Argosy Mufflers +1",
        legs="Sulevia's Cuisses +2",                                --legs={ name="Odyssean Cuisses", augments={'Accuracy+28','Weapon skill damage +5%','DEX+10',}},
        feet="Sulevia's Leggings +2",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",                                   --left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Shukuyu Ring",                                   --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",                                 --right_ring="Epaminondas's Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Fell Cleave'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Full Break'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Scourge'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Ground Strike'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Shockwave'] = sets.precast.WS['Savage Blade']
    
    -- Twofold physical attack, 80% STR ------------------------------------
	sets.precast.WS['Ukko\'s Fury'] = {
        ammo="Knobkierrie",
	    head={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}}, --head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}}, --body="Pummeler's Lorica +2",
        hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
        legs={ name="Argosy Breeches +1", augments={'STR+12','Attack+25','"Store TP"+6',}}, --legs={ name="Valor. Hose", augments={'Accuracy+19 Attack+19','Weapon skill damage +2%','STR+4','Accuracy+15','Attack+12',}},
        feet="Sulevia's Leggings +2",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},  --right_ear="Telos Earring",
        left_ring="Shukuyu Ring",                                    --left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Spiral Hell'] = sets.precast.WS['Ukko\'s Fury']
	
	sets.precast.WS['Entropy'] = sets.precast.WS['Ukko\'s Fury'] 
    
    -- Single hit physical crit, 100% STR ---------------------------------
    sets.precast.WS['True Strike'] = sets.precast.WS['Impulse Drive']
    
	--[[
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pummeler's Lorica +2",                                --body="Pummeler's Lorica +3",
        hands="Sulevia's Gauntlets +2",
        legs={ name="Valor. Hose", augments={'Accuracy+19 Attack+19','Weapon skill damage +2%','STR+4','Accuracy+15','Attack+12',}},
        feet="Sulevia's Leggings +2",
        neck="War. Beads +2",
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Begrudging Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
    }
    --]]
	
    ---------------------------------------------------------------------------
    -- Kiting Sets ------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.Kiting = { legs="Hermes' Sandals"}

    ---------------------------------------------------------------------------
    -- Engaged Sets -----------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.engaged = {
        ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Sulevia's Platemail +2",                              --body={ name="Valorous Mail", augments={'Pet: Crit.hit rate +1','Pet: Phys. dmg. taken -3%','Quadruple Attack +3','Accuracy+19 Attack+19',}},
        hands="Sulevia's Gauntlets +2",
        legs ="Agoge Cuisses +2",                                   --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",                                 --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.GA = {
        ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Sulevia's Platemail +2",                              --body={ name="Valorous Mail", augments={'Pet: Crit.hit rate +1','Pet: Phys. dmg. taken -3%','Quadruple Attack +3','Accuracy+19 Attack+19',}},
        hands="Sulevia's Gauntlets +2",
        legs ="Agoge Cuisses +2",                                   --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Flamma Gambieras +2",                                 --not sure feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",                                 --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.GA.Accuracy = {
	    ammo="Seeth. Bomblet +1",
        head="Flamma Zucchetto +2",                                  --head="Pummeler's Mask +3",
        body="Pummeler's Lorica +3",
        hands="Sulevia's Gauntlets +2",                             --hands="Pummeler's Mufflers +3",
        legs ="Pummeler's Cuisses +2",                                   --legs="Pummeler's Cuisses +3",
        feet="Flamma Gambieras +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.GA.LightPDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                               --legs="Pummeler's Cuisses +3",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Moonshade Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Chirich Ring +1",                                --left_ring="Moonbeam Ring",
        right_ring="Niqmaddu Ring",                                 --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.GA.PDT = {
        ammo="Sihirik",
        head="Sulevia's Mask +2",                                   --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --body="Arke Corazza +1",
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --legs="Arke Cosc. +1",
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Patricius Ring",
        right_ring="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	
	}

    sets.engaged.GS = {
	    ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Sulevia's Platemail +2",                              --body={ name="Valorous Mail", augments={'Pet: Crit.hit rate +1','Pet: Phys. dmg. taken -3%','Quadruple Attack +3','Accuracy+19 Attack+19',}},
        hands="Sulevia's Gauntlets +2",
        legs="Pummeler's Cuisses +2",                                    --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.GS.Accuracy = {
	    ammo="Seeth. Bomblet +1",
        head="Pummeler's Mask +2",                                  --head="Pummeler's Mask +3",
        body="Pummeler's Lorica +3",
        hands="Pummeler's Mufflers +2",                             --hands="Pummeler's Mufflers +3",
        legs ="Pummeler's Cuisses +2",                                   --legs="Pummeler's Cuisses +3",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.GS.LightPDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Sulevia's Gauntlets +2",
        --right_ring="Moonbeam Ring",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.GS.PDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",                                   --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --body="Arke Corazza +1",
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --legs="Arke Cosc. +1",
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck="Loricate Torque +1",                                  --neck="War. Beads +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",                              --left_ear="Cessance Earring",
        right_ear="Odnowa Earring +1",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
	}
	
	sets.engaged.Polearm = {
	    ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Sulevia's Platemail +2",                              --body={ name="Valorous Mail", augments={'Pet: Crit.hit rate +1','Pet: Phys. dmg. taken -3%','Quadruple Attack +3','Accuracy+19 Attack+19',}},
        hands="Flamma Manopolas +2",
        legs="Pummeler's Cuisses +2",                                    --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Kentarch Belt +1",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Flamma Ring",
        right_ring="Chirich Ring +1",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.Polearm.LightPDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Sulevia's Gauntlets +2",
        --right_ring="Moonbeam Ring",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.Polearm.PDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --body="Arke Corazza +1",
        hands="Sulevia's Gauntlets +2",
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --legs="Arke Cosc. +1",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Defending Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
    sets.engaged.AxeShield = {}
    
	sets.engaged.SwordShield = {
	    ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Agoge Lorica +1",                                     --body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulevia's Gauntlets +2",                             --hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        --right_ring="Moonbeam Ring",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Flume Belt +1",
        --left_ear="Ethereal Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.SwordShield.Accuracy = {
	    ammo="Ginsen",
        head="Pummeler's Mask +2",                                  --head="Pummeler's Mask +3",
        body="Pummeler's Lorica +3",
        hands="Sulevia's Gauntlets +2",                             --hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        --right_ring="Moonbeam Ring",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Flume Belt +1",
        --left_ear="Ethereal Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.SwordShield.LightPDT = {
	    ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Sulevia's Gauntlets +2",                             --hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        --right_ring="Moonbeam Ring",
        feet="Pummeler's Calligae +2",
        neck="War. Beads +2",
        waist="Flume Belt +1",
        --left_ear="Ethereal Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        left_ring="Defending Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.SwordShield.PDT = {
	    ammo="Ginsen",
        head="Sulevia's Mask +2",                                   --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --body="Arke Corazza +1",
        hands="Sulevia's Gauntlets +2",                             --hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --legs="Arke Cosc. +1",
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",                              --left_ear="Cessance Earring",
        right_ear="Bladeborn Earring",                              --right_ear="Telos Earring",
        --left_ring="Moonbeam Ring",
        --right_ring="Moonbeam Ring",
        back="Moonbeam Cape",
	}
	
    sets.engaged.ClubShield = {}
    sets.engaged.DualWield = {}

    sets.engaged.TH = {
        ammo="Ginsen",
        head="Wh. Rarab Cap +1",--head="Flam. Zucchetto +2",
        body={ name="Valorous Mail", augments={'MND+11','"Cure" potency +1%','"Treasure Hunter"+1','Accuracy+9 Attack+9','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        hands="Sulev. Gauntlets +2",
        legs="Pummeler's Cuisses +2",
        feet="Flam. Gambieras +2",
        neck={ name="War. Beads +2", augments={'Path: A',}},
        waist="Chaac Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    ---------------------------------------------------------------------------
    -- Idle Sets --------------------------------------------------------------
    ---------------------------------------------------------------------------
    sets.idle = {
	    ammo="Sihirik",
        head="Sulevia's Mask +2",                                         --head={ name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --body="Arke Corazza +1",
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},   --legs="Arke Cosciales +1",
        feet="Hermes' Sandals",
        neck="War. Beads +2",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",                              --right_ear="Telos Earring",
        left_ring="Patricius Ring",
        right_ring="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
    
	sets.idle.Town = {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        body="Councilor's Garb",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Hermes' Sandals",
        neck="War. Beads +2",
        waist="Ioskeha Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
    
	sets.idle.Field = {
        ammo="Sihirik",
        head="Sulevia's Mask +2",
        body={ name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet="Hermes' Sandals",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Patricius Ring",
        right_ring="Defending Ring",
        back="Moonbeam Cape",
	}

    sets.idle.Weak = set_combine(sets.idle.Field, {
        --head="Twilight Helm",
        --body="Twilight Mail",
    })

    ---------------------------------------------------------------------------
    -- Custom Idle Sets (customize_idle_set) ----------------------------------
    ---------------------------------------------------------------------------
    sets.idle.Regen = {}
    sets.idle.Reraise = set_combine(sets.idle.Field, sets.Reraise)
    ---------------------------------------------------------------------------
    -- Reraise (Twilight Set) -------------------------------------------------
    ---------------------------------------------------------------------------
    sets.Reraise = { }--head="Twilight Helm", body="Twilight Mail"
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end
function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.hpp < 25 then
    classes.CustomClass = "Reraise"
    end
    if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
end
-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
		eventArgs.handled = false
end
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- Equip Low Health Gear
    if player.hpp < 90 then
            idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    -- Equip Critical Health Gear
    if player.hpp < 25 then
            idleSet = set_combine(idleSet, sets.Reraise)
    end
    return idleSet
end
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff['Restraint'] then
	meleeSet = set_combine(meleeSet, {hands="Boii Mufflers +1"}) 
end
return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "doom" then
        if player.status == 'Engaged' then
            equip(sets.engaged.Doom)
        else
            equip(sets.idle.Doom)
        end
    elseif string.lower(buff) == "terror" or string.lower(buff) == "stun" or string.lower(buff) == "sleep" then
        if player.status == 'Engaged' then
            equip(sets.engaged.DT)
        else
            equip(sets.idle.DT)
        end
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
-- Job-specific toggles.
function job_toggle(field)
end
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        eventArgs.handled = true
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'SAM' then
        set_macro_page(9, 18)
        windower.add_to_chat(16, 'Changing macros to Book: ' .. 2 .. ' and Page: ' .. 10 .. '.  Job Changed to WAR/' .. player.sub_job)
    else
        set_macro_page(9, 18)
        windower.add_to_chat(16, 'Changing macros to Book: ' .. 2 .. ' and Page: ' .. 10 .. '.  Job Changed to WAR/' .. player.sub_job)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 9')
end