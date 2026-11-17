package com.getoffmyroof.screens
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.inventory.Item;
   import com.getoffmyroof.rewards.PlayerRewards;
   import com.getoffmyroof.save.SaveLoadManager;
   import com.getoffmyroof.shop.ShopEvent;
   import com.getoffmyroof.ui.ItemBox;
   import com.getoffmyroof.ui.dialog.Dialog;
   import com.getoffmyroof.ui.dialog.DialogEvent;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.ui.Scrollbar;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ItemShopScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      public var item_shop_scrollbar:Scrollbar;
      
      public var item_shop_area:MovieClip;
      
      private var m_screenManager:ScreenManager;
      
      private var m_audioManager:AudioManager;
      
      private var m_saveLoadManager:SaveLoadManager;
      
      public var item_shop_content:MovieClip;
      
      private var m_itemToBePurchased:Item;
      
      public var txt_points:TextField;
      
      private var m_globalInventory:Inventory;
      
      public var item_shop_mask:MovieClip;
      
      private var m_playerController:PlayerController;
      
      public function ItemShopScreen(param1:IScreenItem = null)
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
         this.initButtons();
         this.initItemShop();
      }
      
      private function initButtons() : void
      {
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
      }
      
      private function onBuyItem(param1:ShopEvent) : void
      {
         var _loc2_:Dialog = null;
         this.m_itemToBePurchased = param1.data.item;
         var _loc3_:int = this.m_itemToBePurchased.value;
         var _loc4_:PlayerRewards = this.m_playerController.rewards;
         if(_loc4_.hasPoints(_loc3_))
         {
            _loc2_ = new Dialog(Dialog.YES_NO,"Are you sure you wish to get the " + this.m_itemToBePurchased.name + " for " + this.m_itemToBePurchased.value + " points?");
            _loc2_.addEventListener(DialogEvent.CLICKED,this.onBuyItemDialogClick,false,0,true);
         }
         else
         {
            _loc2_ = new Dialog(Dialog.OK,"You do not have enough points to unlock " + this.m_itemToBePurchased.name);
         }
         addChild(_loc2_);
      }
      
      override public function dispose() : void
      {
         this.m_audioManager = null;
         this.m_screenManager = null;
         this.m_playerController = null;
         this.m_globalInventory = null;
         this.m_saveLoadManager = null;
         this.m_itemToBePurchased = null;
         getChildByName("btn_main_menu").removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         super.dispose();
      }
      
      private function initItemShop() : void
      {
         var _loc3_:ItemBox = null;
         var _loc5_:Item = null;
         var _loc1_:int = this.m_playerController.rewards.totalPoints;
         this.txt_points.htmlText = "<b>" + _loc1_ + "</b>";
         while(this.item_shop_content.numChildren)
         {
            this.item_shop_content.removeChildAt(0);
         }
         var _loc2_:Array = this.m_globalInventory.items;
         var _loc4_:int = 0;
         for each(_loc5_ in _loc2_)
         {
            if(!this.m_playerController.inventory.hasItem(_loc5_.id))
            {
               _loc3_ = new ItemBox();
               _loc3_.init(_loc5_,ItemBox.BUY_MODE);
               _loc3_.y = _loc3_.height * _loc4_;
               _loc3_.addEventListener(ShopEvent.BUY,this.onBuyItem);
               this.item_shop_content.addChild(_loc3_);
               _loc4_++;
            }
         }
         this.item_shop_scrollbar.init(this.item_shop_content,this.item_shop_mask,this.item_shop_area);
      }
      
      private function onBuyItemDialogClick(param1:DialogEvent) : void
      {
         var _loc5_:Inventory = null;
         var _loc2_:int = this.m_itemToBePurchased.value;
         var _loc3_:PlayerRewards = this.m_playerController.rewards;
         var _loc4_:String = param1.data.button;
         if(_loc4_ == "yes")
         {
            _loc3_.usePoints(_loc2_);
            _loc5_ = this.m_playerController.inventory;
            _loc5_.addItem(this.m_itemToBePurchased);
            this.initItemShop();
            this.m_saveLoadManager.save("local",this.m_playerController.getValueObject());
         }
         else
         {
            this.m_itemToBePurchased = null;
         }
      }
      
      private function onMainMenuClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("MainScreen");
      }
   }
}

