package com.whatthefawk.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class AScreen extends MovieClip implements IScreenItem
   {
      
      private var m_parentScreen:IScreenItem;
      
      private var m_currentScreen:IScreenItem;
      
      private var m_childScreens:Dictionary;
      
      public function AScreen(param1:IScreenItem = null)
      {
         super();
         this.m_parentScreen = param1;
         this.m_currentScreen = this.m_parentScreen == null ? null : this.currentScreen;
         this.m_childScreens = new Dictionary();
      }
      
      public function removeChildScreen(param1:String) : void
      {
         if(this.m_childScreens[param1] != null)
         {
            this.m_childScreens[param1].dispose();
            removeChild(this.m_childScreens[param1]);
            delete this.m_childScreens[param1];
         }
      }
      
      public function addChildScreen(param1:String, param2:Class) : void
      {
         var _loc3_:IScreenItem = new param2(this);
         addChild(_loc3_ as Sprite);
         this.m_childScreens[param1] = _loc3_;
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:IScreenItem = null;
         if(this.m_parentScreen == null && this.m_currentScreen != null)
         {
            this.m_currentScreen.update(param1);
         }
         for each(_loc2_ in this.m_childScreens)
         {
            _loc2_.update(param1);
         }
      }
      
      public function childScreens() : Array
      {
         var _loc2_:AScreen = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.m_childScreens)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get currentScreen() : IScreenItem
      {
         if(this.m_parentScreen)
         {
            return this.m_parentScreen.currentScreen;
         }
         return this.m_currentScreen;
      }
      
      public function clearChildScreens() : void
      {
         var _loc1_:IScreenItem = null;
         for each(_loc1_ in this.m_childScreens)
         {
            _loc1_.dispose();
         }
         this.m_childScreens = new Dictionary();
      }
      
      public function getChildScreen(param1:String) : IScreenItem
      {
         if(!this.m_childScreens[param1])
         {
            throw new Error("<AScreen> Child Screen " + param1 + " does not exist.");
         }
         return this.m_childScreens[param1];
      }
      
      public function setScreen(param1:Class) : void
      {
         if(this.m_parentScreen != null)
         {
            this.m_parentScreen.setScreen(param1);
            return;
         }
         if(this.m_currentScreen != null)
         {
            removeChild(this.m_currentScreen as Sprite);
            this.m_currentScreen.dispose();
         }
         this.m_currentScreen = new param1(this);
         addChild(this.m_currentScreen as Sprite);
      }
      
      public function get parentScreen() : IScreenItem
      {
         return this.m_parentScreen;
      }
      
      public function dispose() : void
      {
         this.m_parentScreen = null;
         this.m_currentScreen = null;
         this.m_childScreens = null;
      }
   }
}

