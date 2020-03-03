-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    -- Begin Kuvo code.
    arts = {}   
    arts.Light = {}
    arts.Light.Types = {'Divine Magic','Healing Magic','Enhancing Magic','Enfeebling Magic'}
    arts.Dark = {}
    arts.Dark.Types = {'Elemental Magic','Dark Magic','Enfeebling Magic'}
    -- End Kuvo code.

    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal', 'PDT')


    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
    
-- Special Augmented Gear
    MerlinicHoodBurst = { name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+11%','Mag. Acc.+8',}}
    MerlinicShalwarBurst = { name="Merlinic Shalwar", augments={'Mag. Acc.+6','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
    MerlinicCrackowsBurst = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','MND+1','Mag. Acc.+6','"Mag.Atk.Bns."+1',}}
    
    MerlinicHoodDrain = { name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +10','DEX+3',}}
    MerlinicJubbahDrain = { name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Drain" and "Aspir" potency +7','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+2',}}
    MerlinicDastanasDrain = { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+30','"Drain" and "Aspir" potency +10','VIT+9',}}
    MerlinicCrackowsDrain = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +8','CHR+2','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}

    MerlinicShalwarDD = { name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Occult Acumen"+7','Mag. Acc.+10','"Mag.Atk.Bns."+11',}}
    MerlinicShalwarDD2 = { name="Merlinic Shalwar", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+4','INT+12','"Mag.Atk.Bns."+15',}}      
    
    MerlinicDastanasFC = { name="Merlinic Dastanas", augments={'Mag. Acc.+8','"Fast Cast"+5','CHR+7','"Mag.Atk.Bns."+8',}}
    LughsCapeDD = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Occ. inc. resist. to stat. ailments+10',}}
    LughsCapeFC = { name="Lugh's Cape", augments={'"Fast Cast"+10',}}

   
    send_command('bind @` gs c cycle CastingMode')
    
    send_command('bind ^` input /ma Stun <t>')
    -- CTRL a
    send_command('bind ^a gs equip sets.idle.Field')
    -- Windows W
    state.WeaponLock = M(false, 'Weapon Lock')
    send_command('bind @w gs c toggle WeaponLock')
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 10;input /item "Warp Ring" <me>')    
    

    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +1"}
    sets.precast.JA['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.precast.JA['Penury'] = {legs="Arbatel Pants +1"}
    sets.precast.JA['Perpetuance'] = {hands="Arbatel Bracers +1"}
    
    sets.precast.JA['Sublimation'] = {
        ammo="Homiliary",
        head="Acad. Mortar. +3",
        neck="Sanctity Necklace",   
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        body="Pedagogy Gown +3",
        hands="Shrieker's Cuffs",
        left_ring="Persis Ring",
        right_ring="Woltaris Ring",
        legs="Perdition Slops",
        feet="Mallquis Clogs +1",
        waist="Porous Rope",
        back="Moonbeam Cape"
    }
    
    sets.precast.JA['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.precast.JA['Ebullience'] = {head="Arbatel Bonnet +1"}
    

    
    
    
    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo="Sapience Orb",            -- 02%
        head="Vanya Hood",              -- 10%
        neck="Voltsurge Torque",        -- 04%
        left_ear="Etiolation Earring",  -- 02%
        right_ear="Loquac. Earring",    -- 01%  
        body=MerlinicJubbahDrain,       -- 06%
        hands=MerlinicDastanasFC,       -- 05%
        left_ring="Rahab Ring",         -- 02%
        right_ring="Kishar Ring",       -- 04%
        back=LughsCapeFC,               -- 10%
        waist="Witful Belt",            -- 03%/03% quick magic
        legs="Gyve Trousers",           -- 04%
        feet="Regal Pumps +1"           -- 07%
    }
    ------------------------------- Total: 60% ---------------------------------

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash"
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
    --neck="Stoicheion Medal"
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    left_ear="Mendi. Earring",
    back="Pahtli Cape",
    left_ring="Lebeche Ring",
    legs="Doyen Pants",
    feet="Vanya Clogs"
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
    --head=empty,
    --body="Twilight Cloak"
    })
    
    sets.precast.FC.Regen = set_combine(sets.precast.FC, {
    back=LughsCapeFC, 
    hands="Arbatel Bracers +1",
    })
    sets.precast.Klimaform = {feet="Arbatel Loafers +1"}
    
    sets.precast.WS['Myrkr']  = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Elis Tome",
        head="Pedagogy Mortarboard +1",
        neck="Sanctity Necklace",
        left_ear="Etiolation Earring",
        right_ear="Gifted Earring",
        body="Amalric Doublet",
        hands="Shrieker's Cuffs",
        left_ring="Rahab Ring",
        right_ring="Kishar Ring",   
        back="Pahtli Cape",
        waist="Belisama's Rope",
        legs="Amalric Slops",
        feet="Pedagogy Loafers +1",
    }

    

    -- Midcast Sets

    sets.midcast.FastRecast = {
    --  ammo="Incantor Stone",
    --  head="Merlinic Hood",
    --  right_ear="Loquacious Earring",
    --  neck="Voltsurge Torque",
    --  body="Anhur Robe",
    --  hands="Gendewitha Gages",
    --  left_ring="Weatherspoon Ring",
    --  right_ring="Lebeche Ring",
    --  back="Swith Cape +1",
    --  waist="Goading Belt",
    --  legs="Artsieq Hose",
    --  feet="Regal Pumps +1"
    }

    ---------------------------------------------------------------------------
    -- Cure Potency Set ( Healing Magic Skill > MND ) -------------------------
    -- The Cap is 50% for Cure Potency II to take effect ----------------------
    ---------------------------------------------------------------------------
                                            -- Cure Pot.    Mnd     H.M. Skill  Conserve MP 
    sets.midcast.Cure = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",           --                                  +04
        head="Vanya Hood",                  -- 10%                              +06
        neck="Nodens Gorget",               -- 05%
        left_ear="Mendi. Earring",          -- 05%
        right_ear="Regal Earring",          --              +10
        body="Chironic Doublet",            -- 13%
        hands="Pedagogy Bracers +3",        -- 00/03%                     +03
        left_ring="Haoma's Ring",           --                      +08
        right_ring="Sirona's Ring",         --                      +10
        back="Solemnity Cape",              -- 07%          +8                  +05
        waist="Austerity Belt +1", --waist="Luminary Sash",              --              +10                 +04
        legs="Vanya Slops",                 --              +10                 +12
        feet="Vanya Clogs"                  -- 10%                              +06
}
        --------------------------------Total: 50%                  +18         +44

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
        waist="Hachirin-no-Obi",
    })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget",
        left_ring="Levia. Ring",
        right_ring="Levia. Ring"
        })

    sets.midcast.Regen = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Arbatel Bonnet +1",
		body="Telchine Chasuble",
        hands="Telchine Gloves",
        back=LughsCapeDD,        
        waist="Hachirin-no-Obi",
        legs="Telchine Braconi",
        feet="Telchine Pigaches"
    }

    sets.midcast.Cursna = {
        body="Vanya Robe", 
        --neck="Malison Medallion",
        --hands="Hieros Mittens",
		body="Pedagogy Gown +3",
        right_ring="Menelaus's Ring",   -- cursna +25
        right_ring="Haoma's Ring",      -- cursna +15
        feet="Vanya Clogs"              -- cursna +05
        }

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Telchine Cap",
        --neck="Incanter's Torque",
        left_ear="Andoaa Earring",
        right_ear="Calamitous Earring",
        body="Pedagogy Gown +3",
        hands="Telchine Gloves",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
        waist="Embla Sash",
        legs="Telchine Braconi",    
        feet="Telchine Pigaches"
    }

    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Blink'] = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = sets.midcast['Enhancing Magic']
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",
        --waist="Gishdubar Sash",
        --back="Grapevine Cape",
        feet="Inspirited Boots"
        })
    


    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    head="Umuthi Hat", 
    neck="Nodens Gorget",
    waist="Siegel Sash"
    })

    sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Blink'] = sets.midcast['Enhancing Magic']
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers +1"})
    sets.midcast['Sneak'] = sets.midcast['Enhancing Magic']
    sets.midcast['Invisible'] = sets.midcast['Enhancing Magic'] 
    sets.midcast['Protect V'] = sets.midcast['Enhancing Magic']
    sets.midcast['Shell V'] = sets.midcast['Enhancing Magic']
    
    sets.midcast.Protect = {
    left_ring="Sheltered Ring"
    }
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {
    left_ring="Sheltered Ring"
    }
    sets.midcast.Shellra = sets.midcast.Shell
    
    
    

    -- Custom spell classes
    
    sets.midcast['Enfeebling Magic'] = {
        head="Befouled Crown",
        neck="Sanctity Necklace",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Pedagogy Gown +3",              
        hands="Jhakri Cuffs +2",                    
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back=LughsCapeDD,
        waist="Austerity Belt +1",
        legs="Psycloth Lappas",                     
        feet="Jhakri Pigaches +2"                   
    }

 


    sets.midcast['Dark Magic'] = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Pedagogy Gown +3",
        hands="Jhakri Cuffs +2",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
        waist="Porous Rope",
        legs=MerlinicShalwarDD,
        feet="Jhakri Pigaches +2"   
    }

    sets.midcast.Kaustra = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head=MerlinicHoodBurst,         -- 11%          +29     +38     +25
        neck="Mizukage-no-Kubikazari",  -- 10%          +04     +00     +08
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",        --                              +06
        body="Pedagogy Gown +3",
        hands="Jhakri Cuffs +2",        -- 05/05%       +35     +39     +30
        left_ring="Jhakri Ring",            --                      +06     +03
        right_ring="Mujin Band",             -- 00%/05%
        back=LughsCapeDD,           	-- 05%          +26     +20     +10
        waist="Porous Rope",
        legs=MerlinicShalwarDD,         --              +43     +51     +47
        feet="Arbatel Loafers +1",
    }
        
    sets.midcast.Drain = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body=MerlinicJubbahDrain,
        hands=MerlinicDastanasDrain,
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
        waist="Fucho-no-Obi",
        legs=MerlinicShalwarDD,
        feet=MerlinicCrackowsDrain
    }


    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        neck="Erra Pendant",
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        body="Pedagogy Gown +3",
        hands="Jhakri Cuffs +2",
        left_ring="Vertigo Ring",                           --left_ring="Strendu Ring",
        right_ring="Jhakri Ring",
        back=TaranusCapeDD,
        waist="Luminary Sash",
        legs=MerlinicShalwarBurst,
        feet="Jhakri Pigaches +2"                       --feet="Bokwus Boots"
    }

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun)


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        neck="Sanctity Necklace",
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        body="Pedagogy Gown +3",
        hands="Jhakri Cuffs +2",
        left_ring="Vertigo Ring",
        right_ring="Jhakri Ring",
        back=LughsCapeDD,
        waist="Hachirin-no-Obi",                            --waist="Refoccilation Stone",
        legs=MerlinicShalwarDD,
        feet=MerlinicCrackowsDrain
    }

    sets.midcast['Elemental Magic'].Resistant = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        neck="Erra Pendant",
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        body="Pedagogy Gown +3",
        hands="Jhakri Cuffs +2",
        left_ring="Vertigo Ring",
        right_ring="Jhakri Ring",
        back=LughsCapeDD,
        waist="Porous Rope",                            --waist="Refoccilation Stone",
        legs=MerlinicShalwarDD,
        feet=MerlinicCrackowsDrain
    }

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Enki Strap"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Enki Strap"})

    --sets.midcast.Impact = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Dosis Tathlum",
    --    head=empty,neck="Eddy Necklace",left_ear="Psystorm Earring",right_ear="Lifestorm Earring",
    --    body="Twilight Cloak",hands=gear.macc_hagondes,left_ring="Icesoul Ring",right_ring="Sangoma Ring",
    --    back="Toro Cape",waist="Demonry Sash",legs="Hagondes Pants",feet="Bokwus Boots"}
        
        
    sets.midcast['Elemental Magic'].Burst = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",               -- 07/07%       +43     +50     +38
        neck="Mizukage-no-Kubikazari",  -- 10%          +04     +00     +08
        right_ear="Regal Earring",      --              +10     +set    +07
        right_ear="Friomisi Earring",   --                              +06
        body="Ea Houppelande +1",       -- 09%/09%      +48     +52     +44
        hands="Jhakri Cuffs +2",        -- 05/05%       +35     +39     +30
        left_ring="Shiva Ring +1",      --              +09             +03
        right_ring="Mujin Band",        -- 00%/05%
        back=LughsCapeDD,               -- 05%          +26     +20     +10
        waist="Hachirin-no-Obi",
        legs=MerlinicShalwarDD,         --              +43     +51     +47
        feet=MerlinicCrackowsBurst      -- 10%          +24     +28     +38
}


    sets.midcast['Elemental Magic'].Helix = {
        main="Akademos",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head=MerlinicHoodBurst,         -- 11%          +29     +38     +25
        neck="Mizukage-no-Kubikazari",  -- 10%          +04     +00     +08
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",        --                              +06
		body="Pedagogy Gown +3",		--				+39     +40		+52
        hands="Jhakri Cuffs +2",        -- 05/05%       +35     +39     +30
        left_ring="Shiva Ring +1",      --              +09             +03
        right_ring="Mujin Band",             -- 00%/05%
        back="Bookworm's Cape",             -- 05%          +26     +20     +10
        waist="Hachirin-no-Obi",
        legs=MerlinicShalwarDD,         --              +43     +51     +47
        feet="Arbatel Loafers +1",

}



    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {
        main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Homiliary",
        head="Befouled Crown",
        body="Councilor's Garb",
        hands="Shrieker's Cuffs",
        legs="Assid. Pants +1",
        feet="Herald's Gaiters",
        neck="Sanctity Necklace",
        waist="Porous Rope",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Defending Ring",
        right_ring="Woltaris Ring",
        back=LughsCapeDD
    }
    sets.idle.Field = {
        main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Homiliary",
        head="Befouled Crown",
        body="Jhakri Robe +2",
        hands="Shrieker's Cuffs",
        legs="Assid. Pants +1",
        feet="Mallquis Clogs +1",
        neck="Sanctity Necklace",
        waist="Porous Rope",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Defending Ring",
        right_ring="Woltaris Ring",
        back=LughsCapeDD
    }

    sets.idle.Field.PDT = {
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

    sets.idle.Field.Stun = {}

    --[[sets.idle.Weak = {        
        head="Befouled Crown", 
        neck="Loricate Torque +1", 
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        body=MerlinicJubbahDrain,
        hands="Shrieker's Cuffs",
        left_ring="Defending Ring",
        right_ring="Vertigo Ring",
        back="Moonbeam Cape", 
        waist="Porous Rope", 
        legs="Artsieq Hose", 
        feet="Mallquis Clogs +1"
        } ]]
        


    -- Defense sets

    sets.defense.PDT = {
        head="Befouled Crown", 
        neck="Loricate Torque +1", 
        left_ear="Etiolation Earring",
        right_ear="Hearty Earring",
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
        head="Vanya Hood", 
        neck="Sanctity Necklace", 
        left_ear="Etiolation Earring",
        right_ear="Hearty Earring",
        body="Jhakri Robe +2", 
        hands="Shrieker's Cuffs",
        left_ring="Defending Ring",
        right_ring="Vertigo Ring",
        back="Engulfer Cape +1", 
        waist="Porous Rope", 
        legs="Assid. Pants +1", 
        feet="Mallquis Clogs +1"
    }

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers +1"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers +1"}

    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    sets.buff.FullSublimation = {head="Acad. Mortar. +3",
    --left_ear="Savant's Earring",
    body="Pedagogy Gown +3",
    --main="Siriti",
    }
    sets.buff.PDTSublimation = {head="Acad. Mortar. +3",
    --left_ear="Savant's Earring"
    }

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Begin Kuvo code.
    if spell.action_type == 'Magic' then        
        local activeArt = getActiveArt()
        
        -- Warn if magic type is not valid for active art.
        if activeArt ~= 'None' and T(arts[activeArt].Types):contains(spell.skill) == false then
            add_to_chat(8,'--------- Wrong Art Active ---------')
        end
    end 
    -- End Kuvo code.
    
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
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
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
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
function select_default_macro_book()
    send_command('@input //gs enable all')
    set_macro_page(1, 12)
end

-- Kuvo Code
function getActiveArt()
    if buffactive['Light Arts'] or buffactive['Addendum: White'] then
        return "Light"
    elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
        return "Dark"
    else        
        return "None"
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 11')
end