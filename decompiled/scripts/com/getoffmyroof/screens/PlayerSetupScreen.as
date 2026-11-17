package com.getoffmyroof.screens
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.inventory.Equipment;
   import com.getoffmyroof.inventory.EquipmentSlotGroups;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.inventory.Item;
   import com.getoffmyroof.save.SaveLoadManager;
   import com.getoffmyroof.ui.ItemBox;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.ui.DropEvent;
   import com.whatthefawk.ui.Scrollbar;
   import com.whatthefawk.utils.SpriteUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol677")]
   public class PlayerSetupScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      public var inventory_scrollbar:Scrollbar;
      
      private var m_audioManager:AudioManager;
      
      private var mc_playerEquipment:*;
      
      private var mc_inventoryContent:Sprite;
      
      private var m_screenManager:ScreenManager;
      
      public var inventory_area:MovieClip;
      
      public var inventory_content:MovieClip;
      
      private var m_saveLoadManager:SaveLoadManager;
      
      private var m_globalInventory:Inventory;
      
      public var inventory_mask:MovieClip;
      
      public var player_equipment:MovieClip;
      
      private var mc_inventoryScrollbar:Scrollbar;
      
      private var m_playerController:PlayerController;
      
      public function PlayerSetupScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_screenManager = GameComponents.instance.getScreenManager();
         this.m_playerController = GameComponents.instance.getComponent("PlayerController");
         this.m_globalInventory = GameComponents.instance.getComponent("GlobalInventory");
         this.m_saveLoadManager = GameComponents.instance.getComponent("SaveLoadManager");
         if(!this.m_audioManager.isPlaying("MenuMusic"))
         {
            this.m_audioManager.play("MenuMusic",100,1,0,"MenuMusic");
         }
         this.mc_playerEquipment = this.player_equipment;
         this.mc_inventoryContent = this.inventory_content;
         this.mc_inventoryScrollbar = this.inventory_scrollbar;
         this.initButtons();
         this.initInventory();
         this.initEquipment();
      }
      
      private function initEquipment() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:int = this.m_playerController.numProjectileSlots;
         var _loc2_:int = this.m_playerController.maxProjectileSlots;
         var _loc3_:int = 0;
         while(++_loc3_ <= _loc2_)
         {
            _loc4_ = this.mc_playerEquipment["projectile_" + _loc3_];
            if(_loc3_ > _loc1_)
            {
               _loc4_.alpha = 0;
               _loc4_.visible = false;
            }
            else
            {
               _loc4_.num.text = _loc3_;
               _loc4_.addEventListener(MouseEvent.CLICK,this.onSlotClick,false,0,true);
            }
         }
         this.updateEquipmentImages();
      }
      
      private function initButtons() : void
      {
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
      }
      
      private function onSlotClick(param1:MouseEvent) : *
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:Equipment = this.m_playerController.equipment;
         _loc3_.unequip(_loc2_);
         this.updateEquipmentImages();
      }
      
      private function updateEquipmentImages() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Item = null;
         var _loc13_:Sprite = null;
         var _loc1_:Equipment = this.m_playerController.equipment;
         var _loc4_:String = _loc1_.getSlot(EquipmentSlotGroups.MELEE);
         _loc2_ = this.mc_playerEquipment.melee;
         _loc3_ = this.mc_playerEquipment.melee.icon;
         while(_loc3_.numChildren)
         {
            _loc3_.removeChildAt(0);
         }
         var _loc5_:Item = this.m_globalInventory.getItem(_loc4_);
         var _loc6_:Sprite = new Assets[_loc5_.icon]();
         SpriteUtil.resizeSprite(_loc6_,_loc2_.width,_loc2_.height,5);
         _loc3_.addChild(_loc6_);
         var _loc7_:Array = _loc1_.getSlotGroup(EquipmentSlotGroups.PROJECTILE);
         var _loc8_:int = this.m_playerController.numProjectileSlots;
         if(_loc8_ <= 2)
         {
            this.mc_playerEquipment.background.height = 204;
         }
         else if(_loc8_ > 2 && _loc8_ <= 4)
         {
            this.mc_playerEquipment.background.height = 260;
         }
         var _loc9_:int = 0;
         while(++_loc9_ <= _loc8_)
         {
            _loc10_ = _loc7_[_loc9_ - 1];
            _loc11_ = _loc1_.getSlot(_loc10_);
            _loc3_ = this.mc_playerEquipment["projectile_" + _loc9_].icon;
            while(_loc3_.numChildren)
            {
               _loc3_.removeChildAt(0);
            }
            if(_loc11_)
            {
               _loc12_ = this.m_globalInventory.getItem(_loc11_);
               _loc13_ = new Assets[_loc12_.icon]();
               _loc3_.addChild(_loc13_);
            }
         }
      }
      
      override public function dispose() : void
      {
         this.m_screenManager = null;
         this.m_playerController = null;
         this.m_globalInventory = null;
         this.m_saveLoadManager = null;
         super.dispose();
      }
      
      private function onDropItem(param1:DropEvent) : *
      {
         var _loc2_:Item = param1.data.item;
         var _loc3_:String = param1.data.dropTarget;
         var _loc4_:Equipment = this.m_playerController.equipment;
         if(_loc3_ != "melee" && _loc2_.type == "melee")
         {
            return;
         }
         if(_loc3_ == "melee" && _loc2_.type == "projectile")
         {
            return;
         }
         switch(_loc3_)
         {
            case "melee":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_1":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_2":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_3":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_4":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_5":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
               break;
            case "projectile_6":
               _loc4_.unequipItem(_loc2_.id);
               _loc4_.equip(_loc2_.id,_loc3_);
         }
         this.updateEquipmentImages();
      }
      
      private function onMainMenuClick(param1:Event) : void
      {
         this.m_saveLoadManager.save("local",this.m_playerController.getValueObject());
         this.m_screenManager.setScreen("MainScreen");
      }
      
      private function initInventory() : void
      {
         var _loc3_:Item = null;
         var _loc4_:ItemBox = null;
         var _loc1_:Array = this.m_playerController.inventory.items;
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = new ItemBox();
            _loc4_.init(_loc3_,ItemBox.EQUIP_MODE);
            _loc4_.y = _loc4_.height * _loc2_;
            _loc4_.addEventListener(DropEvent.DROP,this.onDropItem,false,0,true);
            this.mc_inventoryContent.addChild(_loc4_);
            _loc2_++;
         }
         this.mc_inventoryScrollbar.init(this.inventory_content,this.inventory_mask,this.inventory_area);
      }
   }
}

