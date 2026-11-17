package com.getoffmyroof.rendering
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.entity.PlayerEvent;
   import com.getoffmyroof.inventory.Equipment;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.inventory.Item;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.getoffmyroof.ui.PlayerUI;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.ARenderer;
   import com.whatthefawk.utils.SpriteUtil;
   import com.whatthefawk.utils.TimeUtil;
   import com.whatthefawk.weapons.WeaponSystem;
   import com.whatthefawk.weapons.WeaponSystemEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   
   public class PlayerUIRenderer extends ARenderer
   {
      
      public var m_playerInfo:MovieClip;
      
      public var m_playerUI:PlayerUI;
      
      public var m_playerUIMovieClip:MovieClip;
      
      public var m_globalInventory:Inventory;
      
      public var m_playerWetnaps:MovieClip;
      
      public var m_playerController:PlayerController;
      
      public var m_playerFace:MovieClip;
      
      public var m_playerHealth:MovieClip;
      
      public function PlayerUIRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3,param4);
         this.m_globalInventory = GameComponents.instance.getComponent("GlobalInventory");
         this.m_playerController = GameComponents.instance.getComponent("PlayerController");
         this.m_playerUI = param1 as PlayerUI;
         this.m_playerUIMovieClip = new param4.movieClip();
         this.m_playerInfo = this.m_playerUIMovieClip.player_info;
         // Renderer translates the world by 106 2/3; move the sidebar the rest.
         this.m_playerInfo.x += 106.6666667;
         this.m_playerFace = this.m_playerInfo.face;
         this.m_playerHealth = this.m_playerInfo.health;
         this.m_playerWetnaps = this.m_playerInfo.wetnaps;
         _container.addChild(this.m_playerUIMovieClip);
         this.setupWeaponDisplay();
         var _loc5_:Player = this.m_playerController.player;
         var _loc6_:WeaponSystem = _loc5_.primaryWeaponSystem;
         var _loc7_:WeaponSystem = _loc5_.secondaryWeaponSystem;
         _loc5_.addEventListener(PlayerEvent.USE_WETNAP,this.onUseWetnap,false,0,true);
         _loc6_.addEventListener(WeaponSystemEvent.SWITCH_WEAPON,this.onSwitchPrimaryWeapon,false,0,true);
         _loc7_.addEventListener(WeaponSystemEvent.SWITCH_WEAPON,this.onSwitchSecondaryWeapon,false,0,true);
      }
      
      private function updateHighCombo() : void
      {
         this.m_playerUIMovieClip.txt_high_combo.text = this.m_playerUI.levelHighCombo;
      }
      
      public function onSwitchSecondaryWeapon(param1:WeaponSystemEvent) : void
      {
         var _loc2_:int = int(param1.data.slot);
         var _loc3_:MovieClip = this.m_playerInfo["projectile_" + _loc2_];
         this.m_playerInfo.projectile_1.gotoAndStop(1);
         this.m_playerInfo.projectile_2.gotoAndStop(1);
         this.m_playerInfo.projectile_3.gotoAndStop(1);
         this.m_playerInfo.projectile_4.gotoAndStop(1);
         this.m_playerInfo.projectile_5.gotoAndStop(1);
         this.m_playerInfo.projectile_6.gotoAndStop(1);
         _loc3_.gotoAndStop(2);
      }
      
      private function updateCombo() : void
      {
         var _loc1_:MovieClip = this.m_playerUIMovieClip.ui_combo;
         var _loc2_:RewardSystem = this.m_playerUI.rewardSystem;
         var _loc3_:Number = (_loc2_.timePassed - _loc2_.timeOfLastKill) / _loc2_.comboDelay;
         if(_loc3_ <= 1 && _loc2_.currentCombo > 0)
         {
            _loc1_.alpha = 1 - _loc3_;
         }
         else
         {
            _loc1_.alpha = 0;
         }
         _loc1_.gfx_combo.txt_combo.text = this.m_playerUI.levelCombo;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.updatePlayerStatus();
         this.updateHighCombo();
         this.updatePoints();
         this.updateCombo();
         this.updateTime();
         this.updateWave();
      }
      
      public function onSwitchPrimaryWeapon(param1:WeaponSystemEvent) : void
      {
      }
      
      private function updatePoints() : void
      {
         this.m_playerUIMovieClip.txt_points.text = this.m_playerUI.levelPoints;
      }
      
      override protected function draw() : void
      {
      }
      
      public function setupWeaponDisplay() : void
      {
         var _loc9_:* = undefined;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Item = null;
         var _loc1_:Equipment = this.m_playerController.equipment;
         var _loc2_:int = this.m_playerController.numProjectileSlots;
         var _loc3_:int = this.m_playerController.maxProjectileSlots;
         var _loc4_:Array = _loc1_.getSlotGroup("projectile");
         this.m_playerInfo.projectile_1.gotoAndStop(2);
         var _loc5_:int = 0;
         while(++_loc5_ <= _loc3_)
         {
            _loc9_ = this.m_playerInfo["projectile_" + _loc5_];
            if(_loc5_ > _loc2_)
            {
               _loc9_.alpha = 0;
               _loc9_.visible = false;
            }
            else
            {
               _loc9_.num.text = _loc5_;
               _loc10_ = _loc4_[_loc5_ - 1];
               _loc11_ = _loc1_.getSlot(_loc10_);
               if(_loc11_)
               {
                  _loc12_ = this.m_globalInventory.getItem(_loc11_);
                  this.addIconToProjectileSlot(new Assets[_loc12_.icon](),_loc5_);
               }
            }
         }
         var _loc6_:String = _loc1_.getSlot("melee");
         var _loc7_:Item = this.m_globalInventory.getItem(_loc6_);
         var _loc8_:Sprite = new Assets[_loc7_.icon]();
         SpriteUtil.fitSpriteInSprite(this.m_playerInfo.melee,_loc8_,5);
      }
      
      private function updatePlayerStatus() : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc1_:int = this.m_playerUI.player.lifeSystem.life;
         var _loc2_:int = this.m_playerUI.player.lifeSystem.maxLife;
         var _loc3_:int = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc7_ = this.m_playerHealth["health_" + _loc3_];
            _loc8_ = (_loc1_ >= _loc3_) + 1;
            _loc7_.gotoAndStop(_loc8_);
            _loc3_++;
         }
         var _loc4_:int = this.m_playerUI.player.numWetnaps;
         var _loc5_:int = this.m_playerUI.player.maxWetnaps;
         var _loc6_:int = 1;
         while(_loc6_ <= _loc5_)
         {
            _loc9_ = this.m_playerWetnaps["wetnap_" + _loc6_];
            _loc10_ = (_loc4_ >= _loc6_) + 1;
            _loc9_.gotoAndStop(_loc10_);
            _loc6_++;
         }
         this.m_playerFace.gotoAndStop(_loc1_);
      }
      
      override protected function updateViewBox() : void
      {
      }
      
      private function updateWave() : void
      {
         var _loc1_:int = this.m_playerUI.levelCurrentWave;
         var _loc2_:int = this.m_playerUI.levelNumWaves;
         this.m_playerUIMovieClip.txt_wave.text = _loc1_ + " / " + _loc2_;
      }
      
      private function updateTime() : void
      {
         this.m_playerUIMovieClip.txt_time.text = TimeUtil.formatTime(this.m_playerUI.levelTime);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:Player = this.m_playerController.player;
         var _loc2_:WeaponSystem = _loc1_.primaryWeaponSystem;
         var _loc3_:WeaponSystem = _loc1_.secondaryWeaponSystem;
         _loc1_.removeEventListener(PlayerEvent.USE_WETNAP,this.onUseWetnap);
         _loc2_.removeEventListener(WeaponSystemEvent.SWITCH_WEAPON,this.onSwitchPrimaryWeapon);
         _loc3_.removeEventListener(WeaponSystemEvent.SWITCH_WEAPON,this.onSwitchSecondaryWeapon);
         this.m_playerUI = null;
         this.m_playerUIMovieClip = null;
         this.m_playerInfo = null;
         this.m_playerFace = null;
         this.m_playerHealth = null;
         this.m_playerWetnaps = null;
         this.m_globalInventory = null;
         this.m_playerController = null;
      }
      
      public function addIconToProjectileSlot(param1:Sprite, param2:int) : void
      {
         var _loc3_:Sprite = this.getProjectileSlot(param2);
         var _loc4_:DisplayObject = _loc3_.getChildByName("icon");
         if(_loc4_)
         {
            _loc3_.removeChild(_loc4_);
         }
         param1.name = "icon";
         _loc3_.addChild(param1);
      }
      
      public function getProjectileSlot(param1:int) : Sprite
      {
         if(this.m_playerInfo["projectile_" + param1] != null)
         {
            return this.m_playerInfo["projectile_" + param1];
         }
         return null;
      }
      
      private function onUseWetnap(param1:Event) : void
      {
         this.m_playerFace.hand.gotoAndPlay(1);
      }
   }
}

