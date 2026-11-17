package com.getoffmyroof.controllers
{
   import SWFStats.Log;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.inventory.Equipment;
   import com.getoffmyroof.inventory.EquipmentSlotGroups;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.rewards.LevelRewards;
   import com.getoffmyroof.rewards.PlayerRewards;
   import com.getoffmyroof.save.ISaveable;
   import com.getoffmyroof.save.IValueObject;
   import com.getoffmyroof.save.LevelVO;
   import com.getoffmyroof.save.PlayerVO;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.audio.AudioTypes;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rewards.achievements.AchievementManager;
   import com.whatthefawk.utils.Input;
   import com.whatthefawk.utils.KeyCode;
   import com.whatthefawk.weapons.melee.MeleeWeapon;
   import com.whatthefawk.weapons.melee.MeleeWeaponFactory;
   import com.whatthefawk.weapons.projectile.ProjectileWeapon;
   import com.whatthefawk.weapons.projectile.ProjectileWeaponFactory;
   import flash.events.EventDispatcher;
   
   public class PlayerController extends EventDispatcher implements ISaveable
   {
      
      protected var _player:Player;
      
      protected var _playerRewards:PlayerRewards;
      
      protected var _numProjectileSlots:int = 2;
      
      protected var _equipment:Equipment;
      
      protected var _gameFactory:GameFactory;
      
      protected var _audioManager:AudioManager;
      
      protected var _meleeWeaponFactory:MeleeWeaponFactory;
      
      protected var _playerID:String = "Player";
      
      protected var _inventory:Inventory;
      
      protected var _achievementManager:AchievementManager;
      
      protected var _projectileWeaponFactory:ProjectileWeaponFactory;
      
      protected var _maxProjectileSlots:int = 6;
      
      public var hasSeenTutorial:Boolean = false;
      
      protected var _globalInventory:Inventory;
      
      public function PlayerController(param1:GameFactory, param2:MeleeWeaponFactory, param3:ProjectileWeaponFactory)
      {
         super();
         this._gameFactory = param1;
         this._meleeWeaponFactory = param2;
         this._projectileWeaponFactory = param3;
         this._globalInventory = GameComponents.instance.getComponent("GlobalInventory");
         this._audioManager = GameComponents.instance.getAudioManager();
         this._achievementManager = GameComponents.instance.getComponent("AchievementManager");
         this._inventory = new Inventory();
         this._equipment = new Equipment();
         this._playerRewards = new PlayerRewards();
         this._equipment.addSlotGroup("melee");
         this._equipment.addSlotGroup("projectile");
         this._equipment.addSlot("melee","melee");
         this._equipment.addSlot("projectile_1","projectile");
         this._equipment.addSlot("projectile_2","projectile");
         this._equipment.addSlot("projectile_3","projectile");
         this._equipment.addSlot("projectile_4","projectile");
         this._equipment.addSlot("projectile_5","projectile");
         this._equipment.addSlot("projectile_6","projectile");
      }
      
      public function update(param1:int) : void
      {
         if(!this._player.lifeSystem.isDead)
         {
            this.handleInput();
         }
      }
      
      public function get equipment() : Equipment
      {
         return this._equipment;
      }
      
      public function get maxProjectileSlots() : int
      {
         return this._maxProjectileSlots;
      }
      
      public function handleInput() : void
      {
         var _loc1_:Input = Input.instance;
         if(_loc1_.isKeyDown(KeyCode.A))
         {
            this._player.walk(new Vector2D(-this._player.maxForce,0));
         }
         else if(_loc1_.isKeyDown(KeyCode.D))
         {
            this._player.walk(new Vector2D(this._player.maxForce,0));
         }
         else if(!_loc1_.isKeyDown(KeyCode.A) && !_loc1_.isKeyDown(KeyCode.D) && !this._player.isInAir)
         {
            this._player.stop(0.8);
         }
         if(_loc1_.isKeyPressed(KeyCode.SPACEBAR))
         {
            this._player.jump();
         }
         if(_loc1_.isKeyPressed(KeyCode.Q))
         {
            this._player.useWetnap();
         }
         if(_loc1_.isKeyPressed(KeyCode.W))
         {
            this._player.activatePrimaryWeapon();
         }
         else if(_loc1_.isKeyReleased(KeyCode.W))
         {
            this._player.deactivatePrimaryWeapon();
         }
         if(_loc1_.isMousePressed)
         {
            this._player.activateSecondaryWeapon();
         }
         else if(_loc1_.isMouseReleased)
         {
            this._player.deactivateSecondaryWeapon();
         }
         if(_loc1_.isKeyPressed(KeyCode.ONE))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(1);
         }
         else if(_loc1_.isKeyPressed(KeyCode.TWO))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(2);
         }
         else if(_loc1_.isKeyPressed(KeyCode.THREE))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(3);
         }
         else if(_loc1_.isKeyPressed(KeyCode.FOUR))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(4);
         }
         else if(_loc1_.isKeyPressed(KeyCode.FIVE))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(5);
         }
         else if(_loc1_.isKeyPressed(KeyCode.SIX))
         {
            this._player.secondaryWeaponSystem.switchCurrentWeapon(6);
         }
      }
      
      public function get inventory() : Inventory
      {
         return this._inventory;
      }
      
      public function resetPlayer() : void
      {
         this._player.reset();
      }
      
      public function loadEquipment() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:ProjectileWeapon = null;
         var _loc1_:String = this._equipment.getSlot(EquipmentSlotGroups.MELEE);
         var _loc2_:MeleeWeapon = this._meleeWeaponFactory.getWeapon(_loc1_,this._player);
         this._player.primaryWeaponSystem.addWeapon(_loc2_,0);
         Log.CustomMetric(_loc1_,"Melee Weapons");
         var _loc3_:Array = this._equipment.getSlotGroup(EquipmentSlotGroups.PROJECTILE);
         var _loc4_:int = 0;
         while(++_loc4_ <= this.numProjectileSlots)
         {
            _loc5_ = _loc3_[_loc4_ - 1];
            _loc6_ = this._equipment.getSlot(_loc5_);
            if(_loc6_)
            {
               Log.CustomMetric(_loc6_,"Projectile Weapons");
               _loc7_ = this._projectileWeaponFactory.getWeapon(_loc6_,this._player);
               this._player.secondaryWeaponSystem.addWeapon(_loc7_,_loc4_);
            }
         }
         this._player.secondaryWeaponSystem.switchCurrentWeapon(1);
      }
      
      public function get player() : Player
      {
         return this._player;
      }
      
      public function loadValueObject(param1:IValueObject) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:LevelRewards = null;
         var _loc2_:PlayerVO = PlayerVO(param1);
         if(!_loc2_)
         {
            this._inventory.addItem(this._globalInventory.getItem("Newspaper"));
            this._inventory.addItem(this._globalInventory.getItem("Rock"));
            this._equipment.equip("Newspaper","melee");
            this._equipment.equip("Rock","projectile_1");
            return;
         }
         this._audioManager.volumeTo(_loc2_.globalVolume);
         this._audioManager.getSoundTransform(AudioTypes.MUSIC).volume = _loc2_.musicVolume;
         this._audioManager.getSoundTransform(AudioTypes.SOUND).volume = _loc2_.soundVolume;
         this._audioManager.getSoundTransform(AudioTypes.INTERFACE).volume = _loc2_.interfaceVolume;
         if(_loc2_.isMuted)
         {
            this._audioManager.volumeTo(_loc2_.globalVolumeBeforeMute);
            this._audioManager.mute();
         }
         this._achievementManager.forceCompleteAchievements(_loc2_.achievements);
         this.hasSeenTutorial = _loc2_.hasSeenTutorial;
         this.rewards.killTypes = _loc2_.killTypes;
         this.rewards.totalKills = _loc2_.totalKills;
         this.rewards.totalPoints = _loc2_.totalPoints;
         this.rewards.highKills = _loc2_.highKills;
         this.rewards.highCombo = _loc2_.highCombo;
         this.rewards.highPoints = _loc2_.highPoints;
         this.rewards.highKillsLevelID = _loc2_.highKillsLevelID;
         this.rewards.highComboLevelID = _loc2_.highComboLevelID;
         this.rewards.highPointsLevelID = _loc2_.highPointsLevelID;
         for(_loc3_ in _loc2_.equipment)
         {
            this._equipment.equip(_loc2_.equipment[_loc3_],_loc3_);
         }
         for each(_loc4_ in _loc2_.inventory)
         {
            _loc6_ = this._globalInventory.getItem(_loc4_);
            this.inventory.addItem(_loc6_);
         }
         for each(_loc5_ in _loc2_.levels)
         {
            _loc7_ = new LevelRewards();
            _loc7_.levelID = _loc5_.levelID;
            _loc7_.kills = _loc5_.highKills;
            _loc7_.highCombo = _loc5_.highCombo;
            _loc7_.points = _loc5_.highPoints;
            _loc7_.time = _loc5_.bestTime;
            _loc7_.medal = _loc5_.medal;
            _loc7_.numDeaths = _loc5_.numDeaths;
            _loc7_.complete = _loc5_.isComplete;
            this.rewards.updateLevelRewards(_loc7_);
         }
      }
      
      public function getValueObject() : IValueObject
      {
         var _loc3_:LevelRewards = null;
         var _loc4_:LevelVO = null;
         var _loc1_:PlayerVO = new PlayerVO();
         _loc1_.killTypes = this.rewards.killTypes;
         _loc1_.totalKills = this.rewards.totalKills;
         _loc1_.totalPoints = this.rewards.totalPoints;
         _loc1_.highKills = this.rewards.highKills;
         _loc1_.highCombo = this.rewards.highCombo;
         _loc1_.highPoints = this.rewards.highPoints;
         _loc1_.highKillsLevelID = this.rewards.highKillsLevelID;
         _loc1_.highComboLevelID = this.rewards.highComboLevelID;
         _loc1_.highPointsLevelID = this.rewards.highPointsLevelID;
         _loc1_.equipment = this.equipment.slots;
         _loc1_.inventory = this.inventory.itemIDs;
         _loc1_.achievements = this._achievementManager.completedAchievementIDs;
         _loc1_.globalVolume = this._audioManager.getSoundTransform().volume;
         _loc1_.musicVolume = this._audioManager.getSoundTransform(AudioTypes.MUSIC).volume;
         _loc1_.soundVolume = this._audioManager.getSoundTransform(AudioTypes.SOUND).volume;
         _loc1_.interfaceVolume = this._audioManager.getSoundTransform(AudioTypes.INTERFACE).volume;
         _loc1_.isMuted = this._audioManager.isMuted;
         _loc1_.globalVolumeBeforeMute = this._audioManager.globalVolumeBeforeMute;
         _loc1_.hasSeenTutorial = this.hasSeenTutorial;
         var _loc2_:Array = [];
         for each(_loc3_ in this.rewards.levelRewards)
         {
            _loc4_ = new LevelVO();
            _loc4_.levelID = _loc3_.levelID;
            _loc4_.highKills = _loc3_.kills;
            _loc4_.highCombo = _loc3_.highCombo;
            _loc4_.highPoints = _loc3_.points;
            _loc4_.bestTime = _loc3_.time;
            _loc4_.medal = _loc3_.medal;
            _loc4_.numDeaths = _loc3_.numDeaths;
            _loc4_.isComplete = _loc3_.complete;
            _loc2_.push(_loc4_);
         }
         _loc1_.levels = _loc2_;
         return _loc1_;
      }
      
      public function get rewards() : PlayerRewards
      {
         return this._playerRewards;
      }
      
      public function loadPlayer(param1:String = null) : Player
      {
         var _loc2_:String = param1 ? param1 : this._playerID;
         this._player = this._gameFactory.getEntity(_loc2_);
         return this._player;
      }
      
      public function get numProjectileSlots() : int
      {
         return this._numProjectileSlots;
      }
   }
}

