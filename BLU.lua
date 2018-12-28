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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Spectral Floe'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Tenebral Crush'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse','Entomb'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades','Anvil Lightning'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
    -- Locks Weapon and Sub via keybind
    state.WeaponLock = M(false, 'Weapon Lock')
    send_command('bind @w gs c toggle WeaponLock')
    -- Fenrir Mount - Windows+x
    send_command('bind @z input /mount fenrir')
    -- Warp Ring - Windows+z
    send_command('bind @x input /equipset 17;input /echo <rarr> Warping!!;wait 10;input /item "Warp Ring" <me>')
    
    -- Special Augmented Gear
    HercWSD = { name="Herculean Boots", augments={'AGI+3','INT+2','Weapon skill damage +9%',}}

    update_combat_form()
    select_default_macro_book()
    set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind @w')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +1",feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +1", feet="Assim. Charuqs +2"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {--legs="Hashishin Tayt",
        back="Rosmerta's Cape"
    }

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Luhlaza bazubands +1"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Sapience Orb",        -- 02%
        head="Amalric Coif +1",        -- 10%
        neck="Voltsurge Torque",    -- 04% 
        left_ear="Etiolation Earring",  -- 01%
        right_ear="Loquac. Earring",     -- 02%
        body="Samnuha Coat",        -- 05%
        hands="Leyline gloves",     -- 05%
        left_ring="Rahab Ring",         -- 02%
        right_ring="Kishar Ring",        -- 04%
        back={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}},
        waist="Witful Belt",        -- 03%
        legs="Ayanmo Cosciales +2", -- 05%      
        --feet="Tutyr Sabots"       -- 00%  "Carmine greaves +1"
    }
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan",})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Falcon Eye",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Herculean Boots",
        neck="Sanctity Necklace",
        waist="Kentarch Belt +1",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    }

    sets.precast.WS['Chant du Cygne'] = {
        ammo="Falcon Eye",
        head="Adhemar Bonnet +1",
        body="Abnoba Kaftan",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Kentarch Belt +1",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    }
    ------------------------- Total: 1233 acc, 1175 att, +253 DEX ---------

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    -- MND (73~85%) based; depending on merits levels
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Hydrocera",
        head="Jhakri Coronal +2",
        body="Assim. Jubbah +3",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Nuna Gorget",             --mnd:8, get elemental obi
        waist="Porous Rope",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Stikini Ring +1",
        right_ring="Leviathan Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
    })
    ------------------------- Total: 1233 acc, 1278 att, +173 MND ---------

    -- MAB and INT Based. MAB is priority. 50% MND / 30% STR.
    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ginsen",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:50, mab:43, mac:46
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Eddy Necklace",           --mac:5, mab:11
        waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",       --int:10, mnd:10, chr:10 macset bonus7, mab:7
        right_ear="Friomisi Earring",   --mab:10
        left_ring="Shiva Ring +1",         --int:8
        right_ring="Shiva Ring +1",        --int:8
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    }
    ------------------------- Total: 1183 acc, 1304 att. +133, +148 MND, +173 STR, +275 Int

    -- 50% STR / 50% MND
    sets.precast.WS['Savage Blade'] = {
        ammo="Ginsen",
        head="Jhakri Coronal +2",
        body="Assimilator's Jubbah +3",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet=HercWSD,
        neck="Sanctity Necklace",
        waist="Latria Sash",
        left_ear="Regal Earring",
        right_ear="Mache Earring",
        left_ring="Ilabrat Ring",
        right_ring="Stikini Ring +1",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    }
    ------------------------- Total: 1250 acc, 1281 att, +173 STR, +152 MND -----
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",       --macc:10
        waist="Austerity Belt +1", --waist="Porous Rope",            --int:5, int:3~7 based on unity ranking
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    }

    sets.midcast['Blue Magic'].PhysicalAcc = {
        ammo="Mavi Tathlum",
        head="Adhemar Bonnet +1",
        body="Assim. Jubbah +3",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Latria Sash",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
        back="Laic Mantle"
    }

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Adhemar Bonnet +1",
        body="Assim. Jubbah +3",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Latria Sash",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
        back="Laic Mantle"
    })

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Dampening Tam",
        body="Assim. Jubbah +3",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Latria Sash",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    })

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Dampening Tam",
        body="Assim. Jubbah +3",
        hands="Adhemar Wristbands +1",
        legs="Ayanmo Cosciales +2",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Latria Sash",
        left_ear="Genmei Earring",
        right_ear="Mache Earring",
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
        back="Laic Mantle"
    })

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Dampening Tam",
        body="Assim. Jubbah +3",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Latria Sash",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    })

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })      

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })      

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Leviathan Ring",
        right_ring="Stikini Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })
    

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })      

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical,
        {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    })      

    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Eddy Necklace",           --mac:5, mab:11
        waist="Austerity Belt +1", --waist="Porous Rope",            --int:5, int:3~7 based on unity ranking
        left_ear="Psystorm Earring",
        right_ear="Lifestorm Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
        }   

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {
        ammo="Mavi Tathlum",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Sanctity Necklace",
        waist="Austerity Belt +1", --waist="Acuity Belt",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    }   

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        ammo="Hydrocera",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Phalaina Locket",
        waist="Austerity Belt +1", --waist="Porous Rope",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Mendi. Earring",
        left_ring="Sirona's Ring",
        right_ring="Haoma's Ring",
        back="Solemnity Cape"
        }

        sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].MagicalMnd,
        {
        head="Pixie Hairpin +1"
        })

    sets.midcast['Blue Magic'].Healing = {
        ammo="Hydrocera",
        head="Jhakri Coronal +2",       --int:33, mab:38, mac:38
        body="Jhakri Robe +2",          --int:47, mab:40, mac:40
        hands="Jhakri Cuffs +2",        --int:33, mab:37, macc:37
        legs="Jhakri Slops +2",         --int:52, mab:45, macc:42
        feet="Jhakri Pigaches +2",      --int:30, mab:36, macc:36
        neck="Phalaina Locket",
        waist="Austerity Belt +1", --waist="Porous Rope",            --int:5, int:3~7 based on unity ranking
        left_ear="Regal Earring",
        right_ear="Mendi. Earring",
        left_ring="Sirona's Ring",
        right_ring="Haoma's Ring",
        back="Solemnity Cape"
        }

    sets.midcast['Blue Magic'].SkillBasedBuff = {
        ammo="Mavi tathlum",
        head="Luh. Keffiyeh +1",
        --neck="Incanter's torque",
        --left_ear="Zennaroi earring",
        right_ear="Loquac. earring",
        body="Assim. Jubbah +3",
        hands="Rawhide gloves",
        left_ring="Vertigo ring",
        --right_ring="Sangoma ring",
        --back="Cornflower cape",
        waist="Austerity Belt +1", --waist="Witful Belt",
        legs="Hashishin Tayt",
        feet="Luhlaza charuqs +1"
        }

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {left_ring="Sheltered Ring"}
    sets.midcast.Protectra = {left_ring="Sheltered Ring"}
    sets.midcast.Shell = {left_ring="Sheltered Ring"}
    sets.midcast.Shellra = {left_ring="Sheltered Ring"}
    

    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {hands="Magus Bazubands"}
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    --[[ sets.resting = {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        body="Hagondes Coat",hands="Serpentes Cuffs",left_ring="Sheltered Ring",right_ring="Paguroidea Ring",
        waist="Austerity Belt",feet="Chelona Boots +1"}
    --]]
    
    -- Idle sets
    sets.idle = {
        ammo="Ginsen",
        head="Rawhide Mask",
        body="Jhakri Robe +2",
        hands="Ayanmo Manopolas +2",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Stikini Ring +1",
        right_ring="Woltaris Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
    }

    sets.idle.PDT = {
        ammo="Ginsen",
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Defending Ring",
        right_ring="Patricius Ring",
        back="Disperser's Cape"
    }

    sets.idle.Town = set_combine(sets.idle, 
        {
        body="Councilor's Garb",
    })

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {
        ammo="Ginsen",
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Defending Ring",
        right_ring="Patricius Ring",
        back="Disperser's Cape"
    }

    sets.defense.MDT = {
        ammo="Ginsen",
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Loricate Torque +1",
        waist="Kentarch Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Moonshade Earring",
        left_ring="Defending Ring",
        right_ring="Vertigo Ring",
        back="Disperser's Cape"
    }

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
        head="Dampening Tam",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Epona's Ring",
        right_ring="Hetairoi Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
    }

    sets.engaged.Acc = {
        ammo="Ginsen",
        head="Dampening Tam",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Kentarch Belt +1",
        left_ear="Mache Earring",
        right_ear="Digni. Earring",
        left_ring="Begrudging Ring",
        right_ring="Varar Ring +1",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
        }   

    sets.engaged.Refresh = {}

    sets.engaged.DW = {
        ammo="Ginsen",
        head="Dampening Tam",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Epona's Ring",
        right_ring="Hetairoi Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
    }

    sets.engaged.DW.Acc = {}

    sets.engaged.DW.Refresh = {}

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    sets.self_healing = {neck="Phalaina Locket"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
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
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    send_command('@input //gs enable all')  
    if player.sub_job == 'DNC' then
        set_macro_page(1, 8)
    else
        set_macro_page(1, 8)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 08')
end